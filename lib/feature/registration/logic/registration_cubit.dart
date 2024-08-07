import 'package:card_swiper/card_swiper.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/enum/dialog_types.dart';
import 'package:my_app/core/helper/app_data/app_data.dart';
import 'package:my_app/feature/registration/data/model/result_api.dart';

import '../data/repository/auth_repository.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final AuthenticationRepository authenticationRepository;

  RegistrationCubit({required this.authenticationRepository})
      : super(RegistrationState(
          formKeyForLogin: GlobalKey<FormState>(),
          formKeyForRegister: GlobalKey<FormState>(),
          cardRegistrationController: SwiperController(),
          emailController: TextEditingController(),
          passwordController: TextEditingController(),
          nameController: TextEditingController(),
          birthdayController: TextEditingController(),
          genderController: TextEditingController(),
          phoneController: TextEditingController(),
        ));

  void showPassword() {
    emit(state.copyWith(isShowPassword: !state.isShowPassword));
  }

  void movePagesCard({required bool isLogin}) {
    state.cardRegistrationController.move(isLogin ? 1 : 0, animation: true);
  }

  Future<void> login({required BuildContext context}) async {
    if (state.formKeyForLogin.currentState!.validate()) {
      emit(state.copyWith(
        dialogTypes: DialogTypes.loading,
      ));
      final String email = state.emailController.text.trim();
      final String password = state.passwordController.text.trim();
      ResultApi resultApi =
          await authenticationRepository.logInWithEmailAndPassword(
              context: context, email: email, password: password);
      // resultApi.value = UserApp.fromJson(resultApi.value);

      if (resultApi.isError) {
        emit(state.copyWith(
          dialogTypes: DialogTypes.error,
          errorMessage: resultApi.value,
        ));
      } else {
        if (!context.mounted) return;
        context.read<AppData>().setUser = resultApi.value;
        emit(state.copyWith(
          dialogTypes: DialogTypes.success,
        ));
      }
    }
  }

  Future<void> signUp({required BuildContext context}) async {
    if (state.formKeyForRegister.currentState!.validate()) {
      final String email = state.emailController.text.trim();

      final String password = state.passwordController.text.trim();
      final String name = state.nameController.text.trim();
      final String phone = state.phoneController.text.trim();
      final String birthday = state.birthdayController.text.trim();
      emit(state.copyWith(dialogTypes: DialogTypes.loading));

      ResultApi resultApi = await authenticationRepository.signUp(
        context: context,
        email: email,
        password: password,
        name: name,
        phone: phone,
        birthday: birthday,
      );
      if (resultApi.isError) {
        emit(
          state.copyWith(
              dialogTypes: DialogTypes.error, errorMessage: resultApi.value),
        );
      } else {
        if (!context.mounted) return;
        context.read<AppData>().setUser = resultApi.value;
        emit(state.copyWith(
          dialogTypes: DialogTypes.success,
        ));
      }
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      emit(state.copyWith(dialogTypes: DialogTypes.signOut));
    } catch (e) {
      throw e.toString();
    }
  }

  void resetDialog() {
    emit(state.copyWith(
      dialogTypes: DialogTypes.initial,
      errorMessage: '',
    ));
  }

  void showDatePicker() {
    emit(state.copyWith(dialogTypes: DialogTypes.showDatePicker));
  }

  void takeDatePicker({required DateTime? date}) {
    emit(state.copyWith(dialogTypes: DialogTypes.initial));
    if (date != null) {
      String dateString = '${date.day}/${date.month}/${date.year}';
      state.birthdayController.text = dateString;
    }
  }
}
