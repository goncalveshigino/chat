// import 'package:chat/src/pages/chats/chats_page.dart';
// import 'package:chat/src/pages/home/controller/home_controller.dart';
// import 'package:chat/src/pages/profile/view/profile_page.dart';
// import 'package:chat/src/pages/users/users_page.dart';
// import 'package:chat/src/utils/my_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class HomePage extends StatelessWidget {

//   HomeController controller = Get.put(HomeController());

//   HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: bottomNavigationBar(context),
//       body: Obx(() => IndexedStack(
//             index: controller.tabIndex.value,
//             children:  [
//               ChatsPage(),
//               UsersPage(),
//               ProfilePage(),
//             ],
//           )),
//     );
//   }

//   Widget bottomNavigationBar(BuildContext context) {
//     return Obx(
//       () => MediaQuery(
//         data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
//         child: Container(
//           height: 15,
//           child: BottomNavigationBar(
//             showUnselectedLabels: true,
//             showSelectedLabels: true,
//             onTap: controller.changesTabIndex,
//             currentIndex: controller.tabIndex.value,
//             backgroundColor: MyColors.primaryColor,
//             unselectedItemColor: Colors.white.withOpacity(0.5),
//             selectedItemColor: Colors.white,
//             items: [
//               BottomNavigationBarItem(
//                 icon: const Icon(
//                   Icons.chat,
//                   size: 20,
//                 ),
//                 label: 'Chats',
//                 backgroundColor: MyColors.primaryColor,
//               ),
//               BottomNavigationBarItem(
//                 icon: const Icon(
//                   Icons.person,
//                   size: 20,
//                 ),
//                 label: 'Users',
//                 backgroundColor: MyColors.primaryColor,
//               ),
//               BottomNavigationBarItem(
//                 icon: const Icon(
//                   Icons.person_pin_rounded,
//                   size: 20,
//                 ),
//                 label: 'Perfil',
//                 backgroundColor: MyColors.primaryColor,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
