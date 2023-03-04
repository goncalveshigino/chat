import 'package:chat/src/pages_routes/page_routes.dart';
import 'package:chat/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/custom_sign_in_or_sign_up.dart';
import '../../../../common_widgets/custom_text_field.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

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
              top: 60,
              left: 25,
              child: CustumSignInOrSignUp(text: 'SignIn'),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  _imageBanner(context),
                  const CustomTextField(
                    hintText: 'Email',
                    icon: Icons.email,
                    textInputType: TextInputType.emailAddress,
                  ),
                  const CustomTextField(
                    hintText: 'Password',
                    icon: Icons.lock,
                    isSecret: true,
                  ),
                  _bottonLogin(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Nao tem uma conta?',
                        style: TextStyle(color: MyColors.primaryColor),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      GestureDetector(
                        child: Text(
                          'Cadastra-se',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: MyColors.primaryColor),
                        ),
                        onTap: () {
                          Get.toNamed(PagesRoutes.signUpRoute);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textLogin() {
    return const Text(
      'SignIn',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
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

  Widget _textFieldPassword() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Password',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            prefixIcon: Icon(
              Icons.lock,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _imageBanner(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 100,
        bottom: MediaQuery.of(context).size.height * 0.22,
      ),
      child: Image.asset(
        'assets/img/chat.png',
        width: 200,
        height: 200,
      ),
    );
  }
}
