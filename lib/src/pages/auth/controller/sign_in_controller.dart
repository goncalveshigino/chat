import 'package:chat/src/providers/users_providers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/response_api.dart';

class SignInController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  void signIn() async {
    
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      ResponseApi responseApi = await usersProvider.singnIn(email, password);

      if (responseApi.success == true) {
        Get.snackbar('Usuario Logado', 'Sessao iniciada');
      } else {
        Get.snackbar('Erro ao Acessar', 'Sessao nao iniciada');
      }
    } else {
      Get.snackbar('Completar os dados', 'Digite seu email e password');
    }
  }
}
