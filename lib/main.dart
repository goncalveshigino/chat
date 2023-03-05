import 'package:chat/src/pages_routes/page_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'src/pages/auth/controller/sign_in_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(SignInController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App Flutter',
      initialRoute: PagesRoutes.signInRoute,
      getPages: AppPages.pages,
      navigatorKey: Get.key,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}
