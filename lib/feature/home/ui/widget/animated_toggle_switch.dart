import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/configuration/controller_app/app_controller_cubit.dart';

import '../../../../configuration/controller_app/app_controller_state.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({super.key});

  Widget rollingIconBuilder(int? value, bool foreground) {
    return Text(textByValue(value));
  }

  String textByValue(int? value) => switch (value) {
        0 => 'EN',
        _ => 'AR',
      };

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppControllerCubit, AppControllerState, Locale>(
        selector: (state) => state.language,
        builder: (context, state) {
          return AnimatedToggleSwitch<int?>.rolling(
            current: state.languageCode == 'en' ? 0 : 1,
            allowUnlistedValues: true,
            values: const [0, 1],
            onTap: (info) {},
            onChanged: (i) {
              context.read<AppControllerCubit>().changeLanguage(
                    i == 0 ? const Locale('en') : const Locale('ar'),
                  );
            },
            iconBuilder: rollingIconBuilder,
            borderWidth: 4.5,
            style: const ToggleStyle(
              backgroundGradient:
                  LinearGradient(colors: [Colors.red, Colors.blue]),
              borderColor: Colors.transparent,
            ),
            height: 35,
            spacing: 20.0,
            loading: false,
          );
        });
  }
}
