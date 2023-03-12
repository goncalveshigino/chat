import 'package:chat/src/models/user_model.dart';
import 'package:chat/src/pages/auth/controller/sign_in_controller.dart';
import 'package:chat/src/pages_routes/page_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

//TODO: remover
UserModel myUser = UserModel.fromJson(GetStorage().read('user') ?? {});

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

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
      initialRoute:
          myUser.id != null ? PagesRoutes.baseRoute : PagesRoutes.signInRoute,
      getPages: AppPages.pages,
      navigatorKey: Get.key,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}
