import 'package:chat/src/api/endpoints.dart';
import 'package:chat/src/models/chat_model.dart';
import 'package:chat/src/pages/chats/controller/chats_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/my_colors.dart';

class ChatsPage extends StatelessWidget {

  ChatsController controller = Get.put(ChatsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.primaryColor,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: controller.getChats(),
          builder: (context, AsyncSnapshot<List<ChatModel>> snapshot) {
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

  Widget cardUser(ChatModel chat) {
    return ListTile(
      onTap: (){},
      title: Text(chat.idUser1 == controller.myUser.id ? chat.nameUser1! : chat.nameUser2!),
      subtitle: Text(''),
      leading: AspectRatio(
        aspectRatio: 1,
        child: ClipOval(
          child: FadeInImage.assetNetwork(
            fit: BoxFit.cover,
            placeholder: 'assets/img/user_profile_2.png',
            image: chat.idUser1 == controller.myUser.id 
                   ? chat.imageUser2 ?? Environment.image_url
                   : chat.imageUser1 ?? Environment.image_url
                
          ),
        ),
      ),
    );
  }
}
