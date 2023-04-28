import 'package:chat/src/models/user_model.dart';
import 'package:chat/src/pages/users/controller/userController.dart';
import 'package:chat/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersPage extends StatelessWidget {
  
  final controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de usuarios', style: TextStyle( color: Colors.white)),
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.primaryColor,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: controller.getUsers(),
          builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data?.isNotEmpty == true) {
                return ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (_, index) {
                    return cardUser(snapshot.data![index]);
                  },
                );
              } else {
                return Container();
              }
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget cardUser(UserModel user) {
    return ListTile(
      onTap: () => controller.goToChat(user),
      title: Text(user.firstname!),
      subtitle: Text(user.email!),
      leading: AspectRatio(
          aspectRatio: 1,
          child: ClipOval(
            child: FadeInImage.assetNetwork(
              fit: BoxFit.cover,
              placeholder: 'assets/img/user_profile_2.png',
              image: user.image ??
                  'https://cdn-icons-png.flaticon.com/512/16/16480.png',
            ),
          ),
        ),
    );
  }
}
