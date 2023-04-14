
import 'package:get/get.dart';

import 'package:chat/src/models/user_model.dart';
import 'package:chat/src/pages_routes/page_routes.dart';
import 'package:chat/src/providers/users_providers.dart';

class UserController extends GetxController {

  UsersProvider usersProvider = UsersProvider();


   Future<List<UserModel>> getUsers() async {
    return await usersProvider.getUsers();
   }

   void goToChat(UserModel user){
      Get.toNamed(PagesRoutes.message, arguments: {
         'user': user.toJson()
      });
   }

}