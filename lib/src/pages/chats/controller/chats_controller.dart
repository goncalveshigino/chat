import 'package:chat/src/models/chat_model.dart';
import 'package:chat/src/models/user_model.dart';
import 'package:chat/src/pages/base/controller/navigation_controller.dart';
import 'package:chat/src/providers/chats_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../pages_routes/page_routes.dart';

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

  void goToChat(ChatModel chat) {
    
    UserModel user = UserModel();

    if (chat.idUser1 == myUser.id) {
      user.id = chat.idUser2;
      user.firstname = chat.nameUser2;
      user.lastname = chat.lastnameUser2;
      user.email = chat.emailUser2;
      user.image = chat.imageUser2;
      user.phone = chat.phoneUser2;
      user.notificationToken = chat.notificationTokenUser2;
    } else {
      user.id = chat.idUser1;
      user.firstname = chat.nameUser1;
      user.lastname = chat.lastnameUser1;
      user.email = chat.emailUser1;
      user.image = chat.imageUser1;
      user.phone = chat.phoneUser1;
      user.notificationToken = chat.notificationTokenUser1;
    }

    Get.toNamed(PagesRoutes.message, arguments: {
      'user': user.toJson(),
    });
  }

  @override
  void onClose() {
    super.onClose();
    navigationController.socket.off('message/${myUser.id}');
  }
}
