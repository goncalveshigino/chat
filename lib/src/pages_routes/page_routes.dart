import 'package:chat/src/pages/home/view/home_page.dart';
import 'package:get/get.dart';

import '../pages/auth/view/sign_in_page.dart';
import '../pages/auth/view/sign_up_page.dart';

abstract class PagesRoutes {
  static const String signInRoute = '/signin';
  static const String signUpRoute = '/signup';
  static const String homeRoute = '/home';
}

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: PagesRoutes.signUpRoute,
      page: () =>  SignUpPage(),
    ),
    GetPage(
      name: PagesRoutes.signInRoute,
      page: () => SignInPage(),
    ),
    GetPage(
      name: PagesRoutes.homeRoute,
      page: () => HomePage(),
    ),
  ];
}
