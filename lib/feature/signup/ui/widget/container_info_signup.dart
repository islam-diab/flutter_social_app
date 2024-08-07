import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/core/helper/spase.dart';
import 'package:my_app/core/theming/text_styles.dart';
import 'package:my_app/feature/signup/ui/widget/signup_form.dart';

import '../../../../core/widget/auth/container_with_opacity.dart';
import '../../../../core/widget/auth/logo_of_another_signup.dart';
import '../../../registration/logic/registration_cubit.dart';

class ContainerInfoForSignup extends StatelessWidget {
  const ContainerInfoForSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerWithOpacity(
      child: Column(
        children: [
          Text(
            'Get Started Free',
            style: AppTextStyles.font40SemiBold,
          ),
          Text(
            ' Free Forever. No Credit Card Needed',
            style: AppTextStyles.font14Medium,
          ),
          verticalSpace(10.h),
          const SignupForm(),
          verticalSpace(20.h),
          LogoOfAnotherSignUp(
            title: 'Already have an account?',
            text: 'Login',
            onPressed: () {
              context.read<RegistrationCubit>().movePagesCard(isLogin: false);
            },
          ),
        ],
      ),
    );
  }
}
