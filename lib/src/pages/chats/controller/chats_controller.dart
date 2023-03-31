import 'package:chat/src/models/chat_model.dart';
import 'package:chat/src/models/user_model.dart';
import 'package:chat/src/providers/chats_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChatsController extends GetxController {
  ChatProvider chatProvider = ChatProvider();

  UserModel myUser = UserModel.fromJson(GetStorage().read('user') ?? {});

  Future<List<ChatModel>> getChats() async {
    return await chatProvider.getChats();
  }
}
