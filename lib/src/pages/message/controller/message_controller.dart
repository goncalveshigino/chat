import 'package:chat/src/models/chat_model.dart';
import 'package:chat/src/models/message_model.dart';
import 'package:chat/src/models/response_api.dart';
import 'package:chat/src/models/user_model.dart';
import 'package:chat/src/pages/base/controller/navigation_controller.dart';
import 'package:chat/src/providers/chats_provider.dart';
import 'package:chat/src/providers/message_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MessageController extends GetxController {
  
  TextEditingController messageController = TextEditingController();

  UserModel userChat = UserModel.fromJson(Get.arguments['user']);
  UserModel myUser = UserModel.fromJson(GetStorage().read('user') ?? {});

  ChatProvider chatProvider = ChatProvider();
  MessageProvider messageProvider = MessageProvider();

  String idChat = '';
  List<MessageModel> messages = <MessageModel>[].obs;

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

  void emitiMessage() {
    navigationController.socket.emit('message', {'id_chat': idChat});
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
  }
}
