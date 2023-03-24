import 'package:chat/src/pages/message/controller/message_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagePage extends StatelessWidget {

  final controller = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 246, 248, 1),
      body: Column(
        children: [
          customAppBar(),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: ListView(
                children: [],
              ),
            ),
          ),
          messageBox(context),
        ],
      ),
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
          const Expanded(
            flex: 10,
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Escreva tua messagem...',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20)),
            ),
          ),
          Expanded(
            flex: 2,
            child: IconButton(
              onPressed: () {},
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
