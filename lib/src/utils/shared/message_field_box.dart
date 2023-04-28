import 'package:flutter/material.dart';

class MessageFieldBox extends StatelessWidget {
 // final ValueChanged<String> onValue;

  const MessageFieldBox({
    super.key,
    //required this.onValue,
  });

  @override
  Widget build(BuildContext context) {
    
    final textController = TextEditingController();
    final focusNode = FocusNode();

    final outlineInputBorder = OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(40));

    final inputDecoration = InputDecoration(
      hintText: 'End your message with a "?"',
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      filled: true,
    );

    return TextFormField(
      onTapOutside: (event) {
        focusNode.unfocus();
      },
      focusNode: focusNode,
      controller: textController,
      decoration: inputDecoration,
      onFieldSubmitted: (value) {
        textController.clear();
        focusNode.requestFocus();
       // onValue(value);
      },
    );
  }
}
