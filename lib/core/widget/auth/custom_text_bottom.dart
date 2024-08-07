import 'package:flutter/material.dart';
import 'package:my_app/core/theming/color.dart';
import 'package:my_app/core/theming/text_styles.dart';

class CustomTextBottom extends StatelessWidget {
  const CustomTextBottom({super.key, required this.onTap, required this.text});
  final void Function()? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.zero,
        height: 55,
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            begin: Alignment(1.00, -0.01),
            end: Alignment(-1, 0.01),
            colors: [Color(0xFF9C3FE4), AppColor.primaryColor],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Center(
            child: Text(
          text,
          style: AppTextStyles.font18Medium,
        )),
      ),
    );
  }
}
