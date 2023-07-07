import 'package:flutter/material.dart';

import '../utils/colors.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPassword;
  final String hintText;
  final TextInputType textInputType;

  const TextFieldInput({
    super.key,
    required this.textEditingController,
    this.isPassword = false,
    required this.hintText,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        fillColor: fieldColor,
        hintText: hintText,
        hintStyle: TextStyle(
            // fontFamily: 'WorkSans',
            ),
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(12),
      ),
      keyboardType: textInputType,
      obscureText: isPassword,
    );
  }
}
