import 'package:chat/src/pages/chats/chats_page.dart';
import 'package:chat/src/pages/profile/view/profile_page.dart';
import 'package:chat/src/pages/users/users_page.dart';
import 'package:chat/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/navigation_controller.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final navigationController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: navigationController.pageController,
        children:  [
         const ChatsPage(),
         const UsersPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: navigationController.currentIndex,
          onTap: (index) {
            navigationController.navigationPageView(index);
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: MyColors.primaryColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withAlpha(100),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Users',
            ),
           
            BottomNavigationBarItem(
              icon: Icon(Icons.person_pin_rounded),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}
