import 'package:flutter/material.dart';

import '../utils/colors.dart';

class StandartButton extends StatelessWidget {
  final Function()? function;
  final Color backgroundColor;
  final String text;
  final Color textColor;
  const StandartButton(
      {super.key,
      this.function,
      required this.backgroundColor,
      required this.text,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: function,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(backgroundColor),
            overlayColor: MaterialStateProperty.all(greyButtonColorActive),
            elevation: MaterialStateProperty.all(
                0), //на скок высоко кнопка над плоскостью - ругулируется тенью
            padding: MaterialStateProperty.all(EdgeInsets.only(
                left: 20, right: 20, top: 13, bottom: 13)), // отступы от краев
            minimumSize: MaterialStateProperty.all(Size(140, 40)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )) //минимальный рамзер // по центру
            ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      alignment: Alignment.center,
      // width: 170,
      height: 50,
    );
  }
}


    //     Container(
    //   // padding: const EdgeInsets.only(top: 28),
    //   child: ElevatedButton(
    //     onPressed: function,
    //     child: Container(
    //       decoration: BoxDecoration(
    //         color: backgroundColor,
    //         borderRadius: BorderRadius.circular(6),
    //       ),
    //       alignment: Alignment.center,
    //       width: 170,
    //       height: 45,
    //       child: Text(
    //         text,
    //         style: TextStyle(
    //           color: textColor,
    //           fontWeight: FontWeight.w500,
    //           fontFamily: 'WorkSans',
    //         ),
    //       ),
    //     ),
    //   ),
    // );