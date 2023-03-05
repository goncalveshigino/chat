import 'package:flutter/material.dart';
import 'package:get/get.dart';




class SignUpController extends GetxController {

  
  TextEditingController emailController = TextEditingController();
  TextEditingController firdtNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController  phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

   void SignUp(){

    String email = emailController.text.trim();
    String name = firdtNameController.text;
    String lastName = lastNameController.text;
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();


    print('Email: $email');
     print('name: $name');
      print('lastName: $lastName');
       print('phone: $phone');
        print('password: $password');
         print('confirmPassword: $confirmPassword');
         
   }
 

}