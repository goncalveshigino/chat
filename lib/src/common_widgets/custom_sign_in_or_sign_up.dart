import 'package:flutter/material.dart';

class CustumSignInOrSignUp extends StatelessWidget {
  final String text;

  const CustumSignInOrSignUp({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    );
  }
}
