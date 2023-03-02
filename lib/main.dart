import 'package:chat/src/pages/auth/login/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Delivery App Flutter',
      initialRoute: 'login',
      routes: {
        'login': (BuildContext contex) => const LoginPage(),
      },
      theme: ThemeData(
         primarySwatch: Colors.red,
      ),
    );
  }
}
