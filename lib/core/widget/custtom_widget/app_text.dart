import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  const AppText(
      {super.key,
      required this.text,
      this.textSize,
      this.textColor,
      this.fontWeight,
      this.maxLines,
      this.letterSpacing});
  final String text;
  final double? textSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final int? maxLines;
  final double? letterSpacing;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: textSize,
        color: textColor,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
