import 'package:chat/src/services/validatores.dart';
import 'package:chat/src/pages/auth/controller/sign_in_controller.dart';
import 'package:chat/src/pages_routes/page_routes.dart';
import 'package:chat/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common_widgets/custom_sign_in_or_sign_up.dart';
import '../../../common_widgets/custom_text_field.dart';

class SignInPage extends StatelessWidget {
  
  SignInPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final controller = SignInController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            
            Positioned(
              top: 80,
              left: -90,
              child: _circleLogin(),
            ),
            const Positioned(
              top: 170,
              left: 25,
              child: CustumSignInOrSignUp(text: 'SignIn'),
            ),
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    
                   Container(
                      height: 200,
                      margin: EdgeInsets.only(
                        top: 100,
                        bottom: MediaQuery.of(context).size.height * 0.22,
                      ),
                    
                    ),
                    CustomTextField(
                      controller: controller.emailController,
                      hintText: 'Email',
                      icon: Icons.email,
                      textInputType: TextInputType.emailAddress,
                      validator: emailValidatores,
                    ),
                    CustomTextField(
                      controller: controller.passwordController,
                      hintText: 'Password',
                      icon: Icons.lock,
                      isSecret: true,
                      validator: passwordValidator,
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
            ),
          ],
        ),
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
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            controller.signIn();
          }
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(vertical: 15)),
        child: const Text(
          'Entrar', 
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _imageBanner(BuildContext context) {
    return Container(
      height: 200,
      margin: EdgeInsets.only(
        top: 100,
        bottom: MediaQuery.of(context).size.height * 0.22,
      ),
     
    );
  }
}
