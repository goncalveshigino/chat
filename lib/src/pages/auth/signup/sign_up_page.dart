import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat/src/utils/my_colors.dart';

import '../../../../common_widgets/custom_sign_in_or_sign_up.dart';
import '../../../../common_widgets/custom_text_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
                child: Column(
                  children: [
                    _imageUser(context),
                  const SizedBox( height: 30,),
                    const CustomTextField(
                      hintText: 'Email',
                      icon: Icons.email,
                      textInputType: TextInputType.emailAddress,
                    ),
                    const CustomTextField(
                      hintText: 'First Name',
                      icon: Icons.person,
                    ), 
                    const CustomTextField(
                      hintText: 'Last Name',
                      icon: Icons.person_outlined,
                    ),
                    const CustomTextField(
                      hintText: 'Phone',
                      icon: Icons.phone,
                      textInputType: TextInputType.phone,
                    ),
                    const CustomTextField(
                      hintText: 'Password',
                      icon: Icons.lock,
                      isSecret: true,
                    ),
                     const CustomTextField(
                      hintText: 'Confirm Password',
                      icon: Icons.lock,
                      isSecret: true,
                    ),
                    _bottonLogin(),
                  ],
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
        onPressed: () {},
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
