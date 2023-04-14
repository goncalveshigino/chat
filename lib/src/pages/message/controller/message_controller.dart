import 'dart:convert';
import 'dart:io';

import 'package:chat/src/models/chat_model.dart';
import 'package:chat/src/models/message_model.dart';
import 'package:chat/src/models/response_api.dart';
import 'package:chat/src/models/user_model.dart';
import 'package:chat/src/pages/base/controller/navigation_controller.dart';
import 'package:chat/src/providers/chats_provider.dart';
import 'package:chat/src/providers/message_provider.dart';
import 'package:chat/src/providers/notification_provider.dart';
import 'package:chat/src/providers/users_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart' as path_provider;

class MessageController extends GetxController {
  final ImagePicker picker = ImagePicker();
  File? imageFile;

  TextEditingController messageController = TextEditingController();

  UserModel userChat = UserModel.fromJson(Get.arguments['user']);
  UserModel myUser = UserModel.fromJson(GetStorage().read('user') ?? {});

  ChatProvider chatProvider = ChatProvider();
  MessageProvider messageProvider = MessageProvider();

  PushNotificationProvider pushNotificationProvider =
      PushNotificationProvider();
  UsersProvider usersProvider = UsersProvider();

  String idChat = '';
  List<MessageModel> messages = <MessageModel>[].obs;
  ScrollController scrollController = ScrollController();
  var isWriting = false.obs;
  var isOnline = false.obs;
  String idSocket = '';

  final navigationController = Get.find<NavigationController>();

  MessageController() {
    createChat();
    checkIfIsOnline();
  }

  void sendNotification(String message, String idMessage, {url = ''}) {
    Map<String, dynamic> data = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'title': '${myUser.firstname}${myUser.lastname}',
      'body': message,
      'id_message': idMessage,
      'id_chat': idChat,
      'url': url
    };

  

    pushNotificationProvider.sendMessage(userChat.notificationToken!, data);
  }

  void listenMessage() {
    navigationController.socket.on('message/$idChat', (data) {
  
      getMessage();
    });
  }

  void listenOnline() {
    navigationController.socket.off('online/${userChat.id}');
    navigationController.socket.on('online/${userChat.id}', (data) {
      isOnline.value = true;
      idSocket = data['id_socket'];
      listenOffline();
    });
  }

  void listenOffline() async {
    if (idSocket.isNotEmpty) {
      navigationController.socket.off('offline/$idSocket');
      navigationController.socket.on('offline/$idSocket', (data) {
        if (idSocket == data['id_socket']) {
          isOnline.value = false;
          navigationController.socket.off('offline/$idSocket');
        }
      });
    }
  }

  void listenWriting() {
    navigationController.socket.on('writing/$idChat/${userChat.id}', (data) {
    
      isWriting.value = true;

      Future.delayed(const Duration(milliseconds: 2000), () {
        isWriting.value = false;
      });
    });
  }

  void listenMessageSeen() {
    navigationController.socket.on('seen/$idChat', (data) {
      print('DATA EMITIDA $data');
      getMessage();
    });
  }

  void listenMessageReceived() {
    navigationController.socket.on('received/$idChat', (data) {
  
      getMessage();
    });
  }

  void emitiMessage() {
    navigationController.socket
        .emit('message', {'id_chat': idChat, 'id_user': userChat.id});
  }

  void emitWriting() {
    navigationController.socket.emit('writing', {
      'id_chat': idChat,
      'id_user': myUser.id,
    });
  }

  void emitMessageSeen() {
    navigationController.socket.emit('seen', {'id_chat': idChat});
  }

  void checkIfIsOnline() async {
    Response response = await usersProvider.checkIfIsOnline(userChat.id!);

    if (response.body['online'] == true) {
      isOnline.value = true;
      idSocket = response.body['id_socket'];
      listenOnline();
    } else {
      isOnline.value = false;
    }
  }

  Future<void> createChat() async {
    ChatModel chat = ChatModel(
      idUser1: myUser.id,
      idUser2: userChat.id,
    );

    ResponseApi responseApi = await chatProvider.create(chat);

    if (responseApi.success == true) {
      idChat = responseApi.data as String;
      checkIfIsOnline();
      getMessage();
      listenMessage();
      listenWriting();
      listenMessageSeen();
      listenOffline();
      listenMessageReceived();
    }
  }

  Future<void> sendMessage() async {
    String messaageText = messageController.text;

    if (messaageText.isEmpty) {
      Get.snackbar('Texto Vazio', 'Escreva uma mensagem');
    }

    if (idChat == '') {
      Get.snackbar('Error', 'Nao foi possivel enviar uma mensagem');
      return;
    }

    MessageModel message = MessageModel(
      message: messaageText,
      idSender: myUser.id,
      idReceiver: userChat.id,
      idChat: idChat,
      isImage: false,
      isVideo: false,
    );

    ResponseApi responseApi = await messageProvider.createMessage(message);

    if (responseApi.success == true) {
      messageController.text = '';
      emitiMessage();
      sendNotification(messaageText, responseApi.data as String);
    }
  }

  Future<void> getMessage() async {
    var result = await messageProvider.getMessages(idChat);
    messages.clear();
    messages.addAll(result);

    messages.forEach((m) async {
      if (m.status != 'VISTO' && m.idReceiver == myUser.id) {
        await messageProvider.updateToSeen(m.id!);
        emitMessageSeen();
      }
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      scrollController.jumpTo(scrollController.position.minScrollExtent);
    });
  }

  Future<File?> compressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 80,
    );

    return result;
  }

  Future selectImages(ImageSource imageSource, BuildContext context) async {
    final XFile? image = await picker.pickImage(source: imageSource);

    if (image != null) {
      imageFile = File(image.path);

      final dir = await path_provider.getTemporaryDirectory();
      final targetPath = "${dir.absolute.path}/temp.jpg";

      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Carregando Imagem...');

      File? compressFile = await compressAndGetFile(imageFile!, targetPath);

      MessageModel message = MessageModel(
        message: "IMAGE",
        idSender: myUser.id,
        idReceiver: userChat.id,
        idChat: idChat,
        isImage: true,
        isVideo: false,
      );

      Stream stream =
          await messageProvider.createWithImage(message, compressFile!);
      stream.listen((res) {
        progressDialog.close();
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

        if (responseApi.success == true) {
          sendNotification(
            '😂Image',
            responseApi.data['id'] as String,
            url: responseApi.data['url'] as String,
          );
          emitiMessage();
        }
      });
    }
  }

  void showAlertDialog(BuildContext context) {
    Widget galleryButtons = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImages(ImageSource.gallery, context);
      },
      child: const Text('Galeria'),
    );
    Widget cameraButtons = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImages(ImageSource.camera, context);
      },
      child: const Text('Camera'),
    );

    AlertDialog alertDialog = AlertDialog(
      title: const Text('Selecione uma imagem'),
      actions: [galleryButtons, cameraButtons],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  Future selectVideos(ImageSource imageSource, BuildContext context) async {
    final XFile? video = await picker.pickVideo(source: imageSource);

    if (video != null) {
      File videoFile = File(video.path);

      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Carregando Video...');

      MessageModel message = MessageModel(
        message: "VIDEO",
        idSender: myUser.id,
        idReceiver: userChat.id,
        idChat: idChat,
        isImage: false,
        isVideo: true,
      );

      Stream stream = await messageProvider.createWithVideo(message, videoFile);
      stream.listen((res) {
        progressDialog.close();
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

        if (responseApi.success == true) {
          sendNotification(
            '🎬 Video novo',
            responseApi.data as String,
          );
          emitiMessage();
        }
      });
    }
  }

  void showAlertDialogForVideo(BuildContext context) {
    Widget galleryButtons = ElevatedButton(
      onPressed: () {
        Get.back();
        selectVideos(ImageSource.gallery, context);
      },
      child: const Text('Galeria'),
    );
    Widget cameraButtons = ElevatedButton(
      onPressed: () {
        Get.back();
        selectVideos(ImageSource.camera, context);
      },
      child: const Text('Camera'),
    );

    AlertDialog alertDialog = AlertDialog(
      title: const Text('Selecione um video'),
      actions: [galleryButtons, cameraButtons],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
    navigationController.socket.off('message/$idChat');
    navigationController.socket.off('seen/$idChat');
    navigationController.socket.off('writing/$idChat/${userChat.id}');
  }
}
