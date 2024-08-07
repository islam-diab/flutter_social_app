import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/core/theming/color.dart';

import '../../../../core/theming/text_styles.dart';

class CustomAppBar extends StatelessWidget {
  final void Function() onPressed;
  const CustomAppBar({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: 55.h, left: 12.w, right: 12.w, bottom: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
              backgroundColor: AppColor.backgroundColorHome,
              radius: 22.r,
              child: IconButton(
                  onPressed: onPressed,
                  icon: const Icon(
                    Icons.dehaze,
                    color: Colors.black,
                  ))),
          Text(
            'Welcome',
            style: AppTextStyles.font20SemiBold,
          ),
          CircleAvatar(
            backgroundColor: AppColor.backgroundColorHome,
            radius: 22.r,
            child: Image.asset(
              'assets/home/camera.png',
              width: 20.w,
              height: 18.h,
            ),
          ),
        ],
      ),
    );
  }
}
