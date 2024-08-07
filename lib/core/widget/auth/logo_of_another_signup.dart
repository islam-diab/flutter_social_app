import 'package:flutter/material.dart';
import 'package:my_app/core/theming/text_styles.dart';

class LogoOfAnotherSignUp extends StatelessWidget {
  const LogoOfAnotherSignUp({
    super.key,
    required this.text,
    required this.onPressed,
    required this.title,
  });
  final String text;
  final String title;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Expanded(
          //       child: Image.asset(
          //         'assets/image/line_left.png',
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 8),
          //       child: Text(
          //         'Or continue with',
          //         style: TextStyles.font14Medium,
          //       ),
          //     ),
          //     Expanded(
          //       child: Image.asset(
          //         'assets/image/line_right.png',
          //       ),
          //     ),
          //   ],
          // ),
          // verticalSpace(20.h),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 90),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       SizedBox(
          //         width: 60.w,
          //         child: Image.asset('assets/image/google.png'),
          //       ),
          //       SizedBox(
          //         width: 60.w,
          //         child: Image.asset('assets/image/facebook.png'),
          //       ),
          //     ],
          //   ),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: AppTextStyles.font14Medium,
              ),
              TextButton(
                onPressed: onPressed,
                child: Text(
                  text,
                  style: AppTextStyles.font14Medium
                      .copyWith(color: const Color(0xffB14A96)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
