import 'package:chat/src/api/endpoints.dart';
import 'package:chat/src/models/chat_model.dart';
import 'package:chat/src/pages/chats/controller/chats_controller.dart';
import 'package:chat/src/utils/relative_time_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/my_colors.dart';

class ChatsPage extends StatelessWidget {
  
  ChatsController controller = Get.put(ChatsController());

  ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.primaryColor,
      ),
      body: Obx(() => SafeArea(
            child: ListView(
              children: getChats(),
            ),
          )),
    );
  }

  Widget circleMessageunRead(int number) {
    return Container(
      margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Container(
            height: 25,
            width: 25,
            color: MyColors.primaryColor,
            alignment: Alignment.center,
            child: Text(
              number.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 10),
              textAlign: TextAlign.center,
            )),
      ),
    );
  }

  List<Widget> getChats() {
    return controller.chats.map((chat) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: cardChat(chat),
      );
    }).toList();
  }

  Widget cardChat(ChatModel chat) {
    return ListTile(
      onTap: () {},
      title: Text(
        chat.idUser1 == controller.myUser.id
            ? chat.nameUser2 ?? ''
            : chat.nameUser1 ?? '',
      ),
      subtitle: Text(chat.lastMessage!),
      trailing: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 7),
            child: Text(
              RelativeTimeUtil.getRelativeTime(chat.lastMessageTimestamp ?? 0),
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ),
          chat.unReadMessage! > 0
              ? circleMessageunRead(chat.unReadMessage ?? 0)
              : const SizedBox(
                  height: 0,
                ),
        ],
      ),
      leading: AspectRatio(
        aspectRatio: 1,
        child: ClipOval(
          child: FadeInImage.assetNetwork(
              fit: BoxFit.cover,
              placeholder: 'assets/img/user_profile_2.png',
              image: chat.idUser1 == controller.myUser.id
                  ? chat.imageUser2 ?? Environment.image_url
                  : chat.imageUser1 ?? Environment.image_url),
        ),
      ),
    );
  }
  //koolmusic..012345678
}
