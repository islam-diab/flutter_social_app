import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/configuration/controller_app/app_controller_cubit.dart';
import 'package:my_app/core/helper/app_data/app_data.dart';
import 'package:my_app/core/routing/app_router.dart';

import 'configuration/controller_app/app_controller_state.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AppData>(
      create: (context) => AppData(),
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        child: BlocProvider<AppControllerCubit>(
          create: (context) => AppControllerCubit(),
          child: BlocBuilder<AppControllerCubit, AppControllerState>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                locale: state.language,
                title: 'Flutter Demo',
                theme: ThemeData(
                  brightness: state.brightness,
                  fontFamily: 'Poppins',
                ),
                onGenerateRoute: AppRouter().generateRoute,
              );
            },
          ),
        ),
      ),
    );
  }
}
