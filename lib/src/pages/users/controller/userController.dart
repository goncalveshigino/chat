

import 'package:chat/src/models/user_model.dart';
import 'package:chat/src/providers/users_providers.dart';
import 'package:get/get.dart';

class UserController extends GetxController {

  UsersProvider usersProvider = UsersProvider();


   Future<List<UserModel>> getUsers() async {
    return await usersProvider.getUsers();
   }

}