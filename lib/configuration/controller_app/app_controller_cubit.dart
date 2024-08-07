import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_controller_state.dart';

class AppControllerCubit extends Cubit<AppControllerState> {
  AppControllerCubit() : super(const AppControllerState());

  void changeLanguage(Locale language) =>
      emit(state.copyWith(language: language));

  void changeTheme(Brightness brightness) {
    emit(
      state.copyWith(brightness: brightness),
    );
  }
}
