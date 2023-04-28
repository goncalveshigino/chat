import 'package:chat/src/models/user_model.dart';
import 'package:chat/src/pages/auth/controller/sign_in_controller.dart';
import 'package:chat/src/pages/auth/controller/sign_up_controller.dart';
import 'package:chat/src/pages_routes/page_routes.dart';
import 'package:chat/src/providers/notification_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'firebase_options.dart';


UserModel myUser = UserModel.fromJson(GetStorage().read('user') ?? {});

PushNotificationProvider pushNotificationProvider = PushNotificationProvider();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  pushNotificationProvider.showNotification(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  pushNotificationProvider.initPushNotification();

  await GetStorage.init();

  Get.put(SignInController());
  Get.put(SignUpController());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  void initState() {
     super.initState();
    pushNotificationProvider.onMessageListiner(); 
  }

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
        //useMaterial3: true,
        colorSchemeSeed: Colors.red
      ),
    );
  }
}
