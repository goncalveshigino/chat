import 'package:chat/src/pages/profile/controller/profile_controller.dart';
import 'package:chat/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  
  ProfilePage({super.key});

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.signOut(),
        backgroundColor: MyColors.primaryColor,
        child: const Icon(Icons.power_settings_new),
      ),
      body: SafeArea(
        child: Column(
          children: [
            circleUser(),
            userInfo(
                'Nome do usuario',
                '${controller.user.firstname!} ${controller.user.lastname!}',
                Icons.person),
            userInfo('Email', controller.user.email!, Icons.email),
            userInfo('Telefone', controller.user.phone!, Icons.phone),
          ],
        ),
      ),
    );
  }

  Widget userInfo(String title, String subtitle, IconData iconData) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
      ),
    );
  }

  Widget circleUser() {
    return Center(
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(top: 30),
        child: AspectRatio(
          aspectRatio: 1,
          child: ClipOval(
            child: FadeInImage.assetNetwork(
              fit: BoxFit.cover,
              placeholder: 'assets/img/user_profile_2.png',
              image: controller.user.image!
            ),
          ),
        ),
      ),
    );
  }
}
