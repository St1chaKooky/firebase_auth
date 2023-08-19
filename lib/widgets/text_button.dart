import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Color color;

  const TextButtonWidget({
    required this.onPressed,
    required this.buttonText,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.white,
      onTap: onPressed,
      highlightColor: Colors.white,
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            buttonText,
            style: TextStyle(color: color),
          ),
        ),
      ),
    );
  }
}
