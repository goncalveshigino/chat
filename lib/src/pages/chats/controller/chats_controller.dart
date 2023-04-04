import 'package:chat/src/models/chat_model.dart';
import 'package:chat/src/models/user_model.dart';
import 'package:chat/src/pages/base/controller/navigation_controller.dart';
import 'package:chat/src/providers/chats_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChatsController extends GetxController {
  final navigationController = Get.find<NavigationController>();
  ChatProvider chatProvider = ChatProvider();

  List<ChatModel> chats = <ChatModel>[].obs;

  ChatsController() {
    getChats();
    listenMessage();
  }

  UserModel myUser = UserModel.fromJson(GetStorage().read('user') ?? {});

  void getChats() async {
    var result = await chatProvider.getChats();
    chats.clear();
    chats.addAll(result);
  }

  void listenMessage() {
    navigationController.socket.on('message/${myUser.id}', (data) {
      getChats();
    });
  }

  @override
  void onClose() {
    super.onClose();
    navigationController.socket.off('message/${myUser.id}');
  }
}
