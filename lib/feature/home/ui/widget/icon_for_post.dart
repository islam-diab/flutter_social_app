import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/core/helper/spase.dart';
import 'package:my_app/core/theming/text_styles.dart';

class IconForPost extends StatelessWidget {
  final String image;
  final double? height;
  final String? text;
  const IconForPost({super.key, required this.image, this.text, this.height});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          image,
          height: height ?? 20.h,
          color: Colors.black,
        ),
        horizontalSpace(7),
        Text(
          text ?? '',
          style: AppTextStyles.font18Bold,
        ),
      ],
    );
  }
}
