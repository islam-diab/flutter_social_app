import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/core/routing/routes.dart';
import 'package:my_app/feature/splash/logic/splash_cubit.dart';

import '../../../core/enum/navigator_splash.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (context) => SplashCubit(context: context),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          switch (state.navigatorSplash) {
            case NavigatorSplash.home:
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.homeScreen, (route) => false);
              break;
            case NavigatorSplash.registration:
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.registrationScreen, (route) => false);
              break;
            default:
          }
        },
        listenWhen: (previous, current) =>
            previous.navigatorSplash != current.navigatorSplash,
        child: Scaffold(
          body: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'HOME OR LOGIN',
                  style: TextStyle(fontSize: 30.sp),
                ),
                20.verticalSpace,
                const CircularProgressIndicator(
                  color: Colors.red,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
