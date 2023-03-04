import 'package:chat/src/pages/auth/signin/sign_in_page.dart';
import 'package:chat/src/pages/auth/signup/signup_page.dart';
import 'package:get/get.dart';

abstract class PagesRoutes {
  static const String signInRoute = '/signin';
  static const String signUpRoute = '/signup';
}

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: PagesRoutes.signUpRoute,
      page: () => const SignUpPage(),
    ),
    GetPage(
      name: PagesRoutes.signInRoute,
      page: () => const SignInPage(),
    ),
  ];
}
