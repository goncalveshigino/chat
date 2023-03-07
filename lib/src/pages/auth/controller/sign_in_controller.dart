import 'package:chat/src/models/user_model.dart';
import 'package:chat/src/pages_routes/page_routes.dart';
import 'package:chat/src/providers/users_providers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../models/response_api.dart';

class SignInController extends GetxController {
  
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  GetStorage storage = GetStorage();

  void signIn() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      ResponseApi responseApi = await usersProvider.singnIn(email, password);

      if (responseApi.success == true) {

        UserModel user = UserModel.fromJson(responseApi.data);
        storage.write('user', user.toJson());
      
        Get.toNamed(PagesRoutes.homeRoute);


      } else {
        Get.snackbar('Erro ao Acessar', 'Sessao nao iniciada');
      }
    } else {
      Get.snackbar('Completar os dados', 'Digite seu email e password');
    }


  }
}
