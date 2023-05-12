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
  
      body: Obx(
        () => SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  circleUser(),
                  const Divider(
                    height: 20,
                  ),
                  userInfo(
                      'Nome do usuario',
                      '${controller.user.value.firstname!} ${controller.user.value.lastname!}',
                      Icons.person),
                  userInfo(
                    'Email',
                    controller.user.value.email!,
                    Icons.email,
                  ),
                  userInfo(
                      'Telefone', controller.user.value.phone!, Icons.phone),
                ],
              ),
              
             

              Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20))),
                  child: PopupMenuButton(
                  position: PopupMenuPosition.under,
                  onSelected: (e){
                    if(e == 'Editar'){
                      controller.goToProfileEdit();
                    }else {
                      controller.signOut();
                    }
                  },

                    itemBuilder: (_){

                      return['Editar','Sair'].map((e){
                        return PopupMenuItem(
                          value: e,
                          child: Text(e),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ],
          ),
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
    return Container(
      width: 150,
      margin: const EdgeInsets.only(top: 30, left: 30),
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipOval(
          child: FadeInImage.assetNetwork(
            fit: BoxFit.cover,
            placeholder: 'assets/img/user_profile_2.png',
            image: controller.user.value.image ??
                'https://cdn-icons-png.flaticon.com/512/16/16480.png',
          ),
        ),
      ),
    );
  }
}
