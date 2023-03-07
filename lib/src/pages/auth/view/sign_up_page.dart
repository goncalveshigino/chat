import 'package:chat/src/pages/auth/controller/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat/src/utils/my_colors.dart';

import '../../../common_widgets/custom_sign_in_or_sign_up.dart';
import '../../../common_widgets/custom_text_field.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final SignUpController controller = SignUpController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: -80,
              left: -100,
              child: _circleLogin(),
            ),
            const Positioned(
              top: 65,
              left: 27,
              child: CustumSignInOrSignUp(
                text: 'SignUp',
              ),
            ),
            Positioned(
              top: 53,
              left: -5,
              child: _iconBack(),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 150),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _imageUser(context),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextField(
                        controller: controller.emailController,
                        hintText: 'Email',
                        icon: Icons.email,
                        textInputType: TextInputType.emailAddress,
                      ),
                      CustomTextField(
                        controller: controller.firstNameController,
                        hintText: 'First Name',
                        icon: Icons.person,
                      ),
                      CustomTextField(
                        controller: controller.lastNameController,
                        hintText: 'Last Name',
                        icon: Icons.person_outlined,
                      ),
                      CustomTextField(
                        controller: controller.phoneController,
                        hintText: 'Phone',
                        icon: Icons.phone,
                        textInputType: TextInputType.phone,
                      ),
                      CustomTextField(
                        controller: controller.passwordController,
                        hintText: 'Password',
                        icon: Icons.lock,
                        isSecret: true,
                      ),
                      CustomTextField(
                        controller: controller.confirmPasswordController,
                        hintText: 'Confirm Password',
                        icon: Icons.lock,
                        isSecret: true,
                      ),
                      _bottonLogin(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconBack() {
    return IconButton(
      onPressed: () => Get.back(),
      icon: const Icon(Icons.arrow_back_ios),
    );
  }

  Widget _circleLogin() {
    return Container(
      width: 240,
      height: 210,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: MyColors.primaryColor,
      ),
    );
  }

  Widget _bottonLogin() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: () {

          if (_formKey.currentState!.validate()) {
            controller.SignUp();
          }
          
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(vertical: 15)),
        child: const Text(
          'Entrar',
        ),
      ),
    );
  }

  Widget _imageUser(BuildContext context) {
    return CircleAvatar(
      backgroundImage: const AssetImage('assets/img/user_profile_2.png'),
      radius: 60,
      backgroundColor: Colors.grey[300],
    );
  }
}
