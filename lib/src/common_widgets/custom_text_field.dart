import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/my_colors.dart';

class CustomTextField extends StatefulWidget {
  
  final IconData icon;
  final String hintText;
  final bool isSecret;
  final List<TextInputFormatter>? inputFormatter;
  final String? initialValue;
  final bool readOnly;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final void Function(String?)? onSaved;
  final GlobalKey<FormFieldState>? fromFieldKey;

  const CustomTextField({
    super.key,
    required this.icon,
    required this.hintText,
    this.isSecret = false,
    this.validator,
    this.controller,
    this.fromFieldKey,
    this.initialValue,
    this.inputFormatter,
    this.onSaved,
    this.readOnly = false,
    this.textInputType,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = false;

  @override
  void initState() {
    super.initState();

    isObscure = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextFormField(
        key: widget.fromFieldKey,
        controller: widget.controller,
        validator: widget.validator,
        keyboardType: widget.textInputType,
        readOnly: widget.readOnly,
        initialValue: widget.initialValue,
        obscureText: isObscure,
        onSaved: widget.onSaved,
        inputFormatters: widget.inputFormatter,
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15),
          hintStyle: TextStyle(color: MyColors.primaryColorDark),
          prefixIcon: Icon(
            widget.icon,
            color: MyColors.primaryColor,
          ),
          suffixIcon: widget.isSecret ? IconButton(onPressed:(){
            setState(() {
              isObscure = !isObscure;
            });
          }, icon: Icon( isObscure ? Icons.visibility : Icons.visibility_off, color: MyColors.primaryColor,),
          ): null
        ),
      ),
    );
  }
}
