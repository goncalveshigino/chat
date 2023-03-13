import 'package:chat/src/pages/base/base_screen.dart';
import 'package:chat/src/pages/base/binding/navigation_binding.dart';
import 'package:get/get.dart';

import '../pages/auth/view/sign_in_page.dart';
import '../pages/auth/view/sign_up_page.dart';

abstract class PagesRoutes {
  static const String signInRoute = '/signin';
  static const String signUpRoute = '/signup';
  static const String baseRoute = '/base';
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
      name: PagesRoutes.baseRoute,
      page: () => const BaseScreen(),
      bindings: [
        NavigationBinding()
      ]
    ),
  ];
}
