import 'dart:convert';
import 'dart:io';

import 'package:chat/src/models/user_model.dart';
import 'package:chat/src/pages/profile/controller/profile_controller.dart';
import 'package:chat/src/providers/users_providers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import '../../models/response_api.dart';

class ProfileEditController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  UserModel user = UserModel.fromJson(GetStorage().read('user') ?? {});

  final ImagePicker picker = ImagePicker();
  File? imageFile;

  UsersProvider usersProvider = UsersProvider();
  final profileController = Get.find<ProfileController>();

  ProfileEditController() {
    nameController.text = user.firstname ?? '';
    lastnameController.text = user.lastname ?? '';
    phoneController.text = user.phone ?? '';
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

  void updateUser(BuildContext context) async {
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text;

    UserModel u = UserModel(
        id: user.id,
        firstname: name,
        lastname: lastname,
        phone: phone,
        email: user.email,
        sessionToken: user.sessionToken,
        image: user.image);

    ProgressDialog progressDialog = ProgressDialog(context: context);

    progressDialog.show(max: 100, msg: 'Atualizando...');

    if (imageFile == null) {
      ResponseApi responseApi = await usersProvider.update(u);

      progressDialog.close();

      saveSession(responseApi);

    } else {
      Stream stream = await usersProvider.updateWithImage(u, imageFile!);
      stream.listen(
        (res) {
          ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

          progressDialog.close();

          saveSession(responseApi);
        },
      );
    }
  }

  void saveSession(dynamic responseApi) {

    print('Usuario Atualizado ${responseApi.data}');

    if (responseApi.success == true) {
      UserModel userResponse = UserModel.fromJson(responseApi.data);
      GetStorage().write('user', userResponse.toJson());
      profileController.user.value = userResponse;
      Get.snackbar('Usuario Atualizado', responseApi.message!);
    } else {
      Get.snackbar('Erro ao atualizar usuario', responseApi.message!);
    }
  }
}
