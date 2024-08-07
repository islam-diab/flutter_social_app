import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/core/helper/spase.dart';
import 'package:my_app/core/theming/text_styles.dart';
import 'package:my_app/core/widget/auth/text_form_field.dart';
import 'package:my_app/feature/registration/logic/registration_cubit.dart';

import '../../../../core/widget/auth/custom_text_bottom.dart';

class UserAndPassword extends StatelessWidget {
  const UserAndPassword({super.key});

  // String? emailAddress, password;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        return Form(
          key: state.formKeyForLogin,
          child: Column(
            children: [
              AppTextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email must not be empty';
                  }
                  return null;
                },
                controller: state.emailController,
                hintText: 'Email Address',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(Icons.person_outline),
              ),
              verticalSpace(30.h),
              BlocSelector<RegistrationCubit, RegistrationState, bool>(
                selector: (state) {
                  return state.isShowPassword;
                },
                builder: (context, isShowPassword) {
                  return AppTextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password must not be empty';
                        }
                        return null;
                      },
                      controller: state.passwordController,
                      isObscureText: isShowPassword,
                      hintText: 'password',
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      prefixIcon: const Icon(Icons.key_outlined),
                      suffixIcon: IconButton(
                          onPressed: () {
                            context.read<RegistrationCubit>().showPassword();
                          },
                          icon: Icon(
                            isShowPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          )));
                },
              ),
              verticalSpace(10.h),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Forgot Password !',
                  style: AppTextStyles.font14Medium,
                ),
              ),
              verticalSpace(30.h),
              CustomTextBottom(
                text: 'Login',
                onTap: () {
                  context.read<RegistrationCubit>().login(context: context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
