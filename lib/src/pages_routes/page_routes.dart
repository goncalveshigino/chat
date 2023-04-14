import 'package:chat/src/pages/base/base_screen.dart';
import 'package:chat/src/pages/base/binding/navigation_binding.dart';
import 'package:chat/src/pages/message/view/message_page.dart';

import 'package:get/get.dart';

import '../pages/auth/view/sign_in_page.dart';
import '../pages/auth/view/sign_up_page.dart';
import '../pages/profile_edit/profile_edit_page.dart';

abstract class PagesRoutes {
  static const String signInRoute = '/signin';
  static const String signUpRoute = '/signup';
  static const String profileEdit = '/profile/edit';
  static const String message = '/message';
  static const String baseRoute = '/base';
  //static const String homeRoute = '/home';
}

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: PagesRoutes.signUpRoute,
      page: () => SignUpPage(),
    ),
    GetPage(
      name: PagesRoutes.signInRoute,
      page: () => SignInPage(),
    ),
    GetPage(
      name: PagesRoutes.profileEdit,
      page: () => ProfileEditPage(),
    ),
    GetPage(
      name: PagesRoutes.message,
      page: () => MessagePage(),
    ),
    GetPage(
      name: PagesRoutes.baseRoute,
      page: () => const BaseScreen(),
      bindings: [NavigationBinding()],
    ),
    // GetPage(
    //   name: PagesRoutes.homeRoute,
    //   page: () => HomePage(),
    // )
  ];
}
