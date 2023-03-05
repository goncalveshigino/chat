

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

   

   void SignIn() {

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    print('Email: $email');
    print('Password: $password');
    
   }
}