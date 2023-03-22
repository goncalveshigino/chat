import 'package:chat/src/common_widgets/custom_text_field.dart';
import 'package:chat/src/profile_edit/profile_edit_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/my_colors.dart';

class ProfileEditPage extends StatelessWidget {

 

  final controller = Get.put(ProfileEditController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottonEdit(context),
      appBar: AppBar(
        title: const Text('Perfil de usuario '),
        backgroundColor: MyColors.primaryColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
      
           const  SizedBox(height: 50,),
              _imageUser(context),
            const  SizedBox(height: 20,),
              CustomTextField(
                controller: controller.nameController,
                hintText: 'First Name',
                icon: Icons.person,
              ),
              CustomTextField(
                controller: controller.lastnameController,
                hintText: 'Last Name',
                icon: Icons.person_outlined,
              ),
              CustomTextField(
                controller: controller.phoneController,
                hintText: 'Phone',
                icon: Icons.phone,
                textInputType: TextInputType.phone,
              ),
          ],
        ),
      ),
    );
  }

  Widget _bottonEdit(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: () => controller.updateUser(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: const Text(
          'EDITAR PERFIL',
        ),
      ),
    );
  }

  Widget _imageUser(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.showAlertDialog(context),
      child: GetBuilder<ProfileEditController>(
        builder: (value) => CircleAvatar(
          backgroundImage: controller.imageFile != null
              ? FileImage(controller.imageFile!)
              : controller.user.email != null
              ? NetworkImage(controller.user.image ?? 'https://cdn-icons-png.flaticon.com/512/16/16480.png')
              : const AssetImage('assets/img/user_profile_2.png')
                  as ImageProvider,
          radius: 60,
          backgroundColor: Colors.grey[300],
        ),
      ),
    );
  }
}
