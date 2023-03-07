import 'package:chat/src/models/user_model.dart';
import 'package:chat/src/providers/users_providers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  void SignUp() async {
    String email = emailController.text.trim();
    String firstname = firstNameController.text;
    String lastName = lastNameController.text;
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (isValidForm(
      email,
      firstname,
      lastName,
      phone,
      password,
      confirmPassword,
    )) {
      UserModel user = UserModel(
          email: email,
          firstname: firstname,
          lastname: lastName,
          phone: phone,
          password: password);

      Response response = await usersProvider.createUser(user);

      if (response.body['success'] == true) {
        clearForm();
      }

      print('Respose: ${response.body}');
    }
  }

  void clearForm() {
    emailController.text = '';
    firstNameController.text = '';
    lastNameController.text = '';
    phoneController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
  }

  bool isValidForm(
    String email,
    String firstname,
    String lastname,
    String phone,
    String password,
    String confirmPassword,
  ) {
    if (email.isEmpty) {
      Get.snackbar('Formulario nao valido', 'digite um email');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
          'Formulario nao valido', 'O email que adicionaste nao e valido');
      return false;
    }

    if (firstname.isEmpty) {
      Get.snackbar('Formulario nao valido', 'Digite seu nome');
      return false;
    }

    if (lastname.isEmpty) {
      Get.snackbar('Formulario nao valido', 'Digite seu sobrenome');
      return false;
    }

    if (phone.isEmpty) {
      Get.snackbar('Formulario nao valido', 'Digite seu numero de telefone');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('Formulario nao valido', 'Digite sua senha');
      return false;
    }

    if (confirmPassword.isEmpty) {
      Get.snackbar('Formulario nao valido', 'Confirma sua senha');
      return false;
    }

    if (password != confirmPassword) {
      Get.snackbar('Formulario nao valido', 'As senhas nao sao iguais');
      return false;
    }

    return true;
  }
}
