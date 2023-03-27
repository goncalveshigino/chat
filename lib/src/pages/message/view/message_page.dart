import 'package:chat/main.dart';
import 'package:chat/src/models/message_model.dart';
import 'package:chat/src/pages/message/controller/message_controller.dart';
import 'package:chat/src/utils/bubble.dart';
import 'package:chat/src/utils/relative_time_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagePage extends StatelessWidget {

  final controller = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 246, 248, 1),
      body: Obx(() => Column(
            children: [
              customAppBar(),
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 50),
                  child: ListView(
                    children: getMessages(),
                  ),
                ),
              ),
              messageBox(context),
            ],
          )),
    );
  }

  List<Widget> getMessages() {
    return controller.messages.map((message) {
      return Container(
        alignment: message.idSender == myUser.id
            ? Alignment.bottomRight
            : Alignment.bottomLeft,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: bunbleMessage(message),
      );
    }).toList();
  }

  Widget bunbleMessage(MessageModel message) {
    return Bubble(
      message: message.message ?? '',
      delivered: true,
      isMe: message.idSender == controller.myUser.id ? true : false,
      status: message.status ?? 'ENVIADO',
      time: RelativeTimeUtil.getRelativeTime(message.timestamp ?? 0),
    );
  }

  Widget messageBox(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 15,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.image_outlined),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.video_call_rounded),
            ),
          ),
          Expanded(
            flex: 10,
            child: TextField(
              controller: controller.messageController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Escreva tua messagem...',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: IconButton(
              onPressed: () => controller.sendMessage(),
              icon: const Icon(Icons.send),
            ),
          )
        ],
      ),
    );
  }

  Widget customAppBar() {
    return SafeArea(
      child: ListTile(
        title: Text(
          '${controller.userChat.firstname ?? ''} ${controller.userChat.lastname ?? ''}',
          style: TextStyle(
              fontSize: 18,
              color: Colors.grey[700],
              fontWeight: FontWeight.bold),
        ),
        subtitle: const Text(
          'Desconctado',
          style: TextStyle(color: Colors.grey),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        trailing: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: AspectRatio(
            aspectRatio: 1,
            child: ClipOval(
              child: FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                placeholder: 'assets/img/user_profile_2.png',
                image: controller.userChat.image ??
                    'https://cdn-icons-png.flaticon.com/512/16/16480.png',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
