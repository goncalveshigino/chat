import 'dart:io';

import 'package:chat/src/models/response_api.dart';
import 'package:chat/src/models/user_model.dart';
import 'package:chat/src/providers/users_providers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignUpController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  final ImagePicker picker = ImagePicker();
  File? imageFile;

  void createUser() async {
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

      ResponseApi response = await usersProvider.createUser(user);

      if (response.success == true) {
        clearForm();
      }
    }
  }

  Future selectImages(ImageSource imageSource) async {
    final XFile? image = await picker.pickImage(source: imageSource);

    if (image != null) {
      imageFile = File(image.path);
      update();
    }
  }

  void showAlertDialog(BuildContext context) {
    
    Widget galleryButtons = ElevatedButton(
      onPressed: () {
        selectImages(ImageSource.gallery);
        Get.back();
      },
      child: const Text('Galeria'),
    );
    Widget cameraButtons = ElevatedButton(
      onPressed: () {
        selectImages(ImageSource.camera);
        Get.back();
      },
      child: const Text('Camera'),
    );

    AlertDialog alertDialog = AlertDialog(
      title: const Text('Selecione uma imagem'),
      actions: [galleryButtons, cameraButtons],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
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
