import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/core/helper/spase.dart';
import 'package:my_app/core/widget/auth/text_form_field.dart';

import '../../../../core/widget/auth/custom_text_bottom.dart';
import '../../../registration/logic/registration_cubit.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      buildWhen: (previous, current) => false,
      builder: (context, state) {
        return Form(
          key: state.formKeyForRegister,
          child: Column(
            children: [
              AppTextFormField(
                hintText: 'Email Address',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(Icons.email_outlined),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email must not be empty';
                  }
                  return null;
                },
                controller: state.emailController,
              ),
              AppTextFormField(
                controller: state.nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'username must not be empty';
                  }
                  return null;
                },
                hintText: 'username',
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(Icons.person_outline),
              ),
              AppTextFormField(
                controller: state.passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'password must not be empty';
                  }
                  return null;
                },
                isObscureText: true,
                hintText: 'password',
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(Icons.key_outlined),
              ),
              AppTextFormField(
                  hintText: 'Phone',
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.phone),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'password must not be empty';
                    }
                    return null;
                  },
                  controller: state.phoneController),
              AppTextFormField(
                controller: state.birthdayController,
                onTap: () {
                  context.read<RegistrationCubit>().showDatePicker();
                },
                readOnly: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'birthday must not be empty';
                  }
                  return null;
                },
                hintText: 'birthday',
                keyboardType: TextInputType.datetime,
                textInputAction: TextInputAction.done,
                prefixIcon: const Icon(Icons.calendar_month_outlined),
              ),
              verticalSpace(10.h),
              CustomTextBottom(
                text: 'Signup',
                onTap: () {
                  context.read<RegistrationCubit>().signUp(context: context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
