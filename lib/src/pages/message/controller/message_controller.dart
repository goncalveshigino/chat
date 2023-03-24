import 'package:chat/src/models/chat_model.dart';
import 'package:chat/src/models/response_api.dart';
import 'package:chat/src/models/user_model.dart';
import 'package:chat/src/providers/chats_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MessageController extends GetxController {
  UserModel userChat = UserModel.fromJson(Get.arguments['user']);
  UserModel myUser = UserModel.fromJson(GetStorage().read('user') ?? {});

  ChatProvider chatProvider = ChatProvider();

  MessageController() {
    print('Usuario chat: ${userChat.toJson()}');
    createChat();
  }

  Future<void> createChat() async {
    ChatModel chat = ChatModel(idUser1: myUser.id, idUser2: userChat.id);

    ResponseApi responseApi = await chatProvider.create(chat);
    Get.snackbar('Chat criado', responseApi.message ?? 'Erro na resposta');
  }
}
