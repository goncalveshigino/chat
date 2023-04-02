import 'dart:convert';
import 'dart:io';

import 'package:chat/src/models/chat_model.dart';
import 'package:chat/src/models/message_model.dart';
import 'package:chat/src/models/response_api.dart';
import 'package:chat/src/models/user_model.dart';
import 'package:chat/src/pages/base/controller/navigation_controller.dart';
import 'package:chat/src/providers/chats_provider.dart';
import 'package:chat/src/providers/message_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class MessageController extends GetxController {
  final ImagePicker picker = ImagePicker();
  File? imageFile;

  TextEditingController messageController = TextEditingController();

  UserModel userChat = UserModel.fromJson(Get.arguments['user']);
  UserModel myUser = UserModel.fromJson(GetStorage().read('user') ?? {});

  ChatProvider chatProvider = ChatProvider();
  MessageProvider messageProvider = MessageProvider();

  String idChat = '';
  List<MessageModel> messages = <MessageModel>[].obs;

  ScrollController scrollController = ScrollController();

  var isWriting = false.obs;

  final navigationController = Get.find<NavigationController>();

  MessageController() {
    print('Usuario chat: ${userChat.toJson()}');
    createChat();
  }

  void listenMessage() {
    navigationController.socket.on('message/$idChat', (data) {
      print('DATA EMITIDA $data');
      getMessage();
    });
  }

  void listenWriting() {
    navigationController.socket.on('writing/$idChat/${userChat.id}', (data) {
      print('DATA EMITIDA $data');
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

  void emitiMessage() {
    navigationController.socket.emit('message', {
      'id_chat': idChat,
      'id_user': userChat.id
    });
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

  Future<void> createChat() async {
    ChatModel chat = ChatModel(
      idUser1: myUser.id,
      idUser2: userChat.id,
    );

    ResponseApi responseApi = await chatProvider.create(chat);

    if (responseApi.success == true) {
      idChat = responseApi.data as String;
      getMessage();
      listenMessage();
      listenWriting();
      listenMessageSeen();
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
