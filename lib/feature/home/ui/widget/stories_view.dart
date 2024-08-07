import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/core/theming/text_styles.dart';

class StoriesView extends StatelessWidget {
  const StoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: const EdgeInsetsDirectional.all(6),
        height: 90.h,
        width: 90.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.indigo,
            width: 2.3,
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.all(3),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 10,
              child: Image.asset(
                'assets/home/1.png',
              ),
            )),
      ),
      Text(
        'You',
        style: AppTextStyles.font13SemiBold,
      )
    ]);
  }
}
