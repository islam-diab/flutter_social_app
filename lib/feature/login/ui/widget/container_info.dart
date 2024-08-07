import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/feature/login/ui/widget/user_pass_form.dart';

import '../../../../core/helper/spase.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widget/auth/container_with_opacity.dart';
import '../../../../core/widget/auth/logo_of_another_signup.dart';
import '../../../registration/logic/registration_cubit.dart';

class ContainerInfo extends StatelessWidget {
  const ContainerInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerWithOpacity(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Welcome !',
            style: AppTextStyles.font40SemiBold,
          ),
          Text(
            'welcome back we missed you',
            style: AppTextStyles.font14Medium,
          ),
          verticalSpace(30.h),
          const UserAndPassword(),
          verticalSpace(30.h),
          LogoOfAnotherSignUp(
            title: 'Don\'t have an account ? ',
            text: 'Sing Up',
            onPressed: () =>
                context.read<RegistrationCubit>().movePagesCard(isLogin: true),
          ),
          // verticalSpace(20.h),
        ],
      ),
    );
  }
}
