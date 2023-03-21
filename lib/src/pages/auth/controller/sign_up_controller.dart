import 'dart:convert';
import 'dart:io';

import 'dart:core';
import 'package:chat/src/models/response_api.dart';
import 'package:chat/src/models/user_model.dart';
import 'package:chat/src/pages_routes/page_routes.dart';
import 'package:chat/src/providers/users_providers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class SignUpController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  GetStorage storage = GetStorage();

  final ImagePicker picker = ImagePicker();
  File? imageFile;

  void createUser(BuildContext context) async {
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
      ProgressDialog progressDialog = ProgressDialog(context: context);

      progressDialog.show(max: 100, msg: 'Cadastrando...');

      UserModel user = UserModel(
          email: email,
          firstname: firstname,
          lastname: lastName,
          phone: phone,
          password: password);

      Stream stream = await usersProvider.createWithImage(user, imageFile!);
      stream.listen((res) {

        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

        progressDialog.close();

        if (responseApi.success == true) {
          
          UserModel user = UserModel.fromJson(responseApi.data);
          storage.write('user', user.toJson());

          goToBaseScreen();
        } else {
          Get.snackbar('Erro ao criar usuario', responseApi.message!);
        }
      });
    }
    //ResponseApi response = await usersProvider.createUser(user);
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
        Get.back();
        selectImages(ImageSource.gallery);
      },
      child: const Text('Galeria'),
    );
    Widget cameraButtons = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImages(ImageSource.camera);
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

    if (imageFile == null) {
      Get.snackbar('Formulario Invalido', 'Seleciona uma imagem de perfil');
      return false;
    }

    return true;
  }

  void goToBaseScreen() {
    Get.offNamedUntil(PagesRoutes.baseRoute, (route) => false);
  }
}
