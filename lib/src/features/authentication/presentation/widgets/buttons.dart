import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';

import '../../../../../cores/util/const_colors.dart';

class Buttons extends StatelessWidget {
  final String buttonText;
  Color? color;
  Color? textColor;
  Color? borderColor;
  final void Function() onPageFunction;
  Buttons({
    super.key,
    required this.buttonText,
    required this.onPageFunction,
    this.color,
    this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPageFunction();
      },
      child: Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
            color: color ?? ConstColor.mainColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor ?? Colors.transparent)),
        child: Center(
            child: Text(buttonText,
                style: TextStyle(
                  color: textColor != null ? textColor : Colors.white,
                  fontSize: 17,
                ))),
      ),
    );
  }
}
