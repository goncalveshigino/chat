

import 'package:chat/src/models/user_model.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {

  UserModel userChat = UserModel.fromJson(Get.arguments['user']);

  MessageController(){
    print('Usuario chat: ${userChat.toJson()}');
  }

}