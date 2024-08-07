part of 'registration_cubit.dart';

class RegistrationState extends Equatable {
  const RegistrationState({
    this.isLogin = true,
    required this.formKeyForLogin,
    required this.formKeyForRegister,
    required this.cardRegistrationController,
    required this.emailController,
    required this.passwordController,
    this.isShowPassword = true,
    this.dialogTypes = DialogTypes.initial,
    this.errorMessage = '',
    required this.nameController,
    required this.phoneController,
    required this.genderController,
    required this.birthdayController,
  });
  final bool isLogin;
  final GlobalKey<FormState> formKeyForLogin;
  final GlobalKey<FormState> formKeyForRegister;
  final SwiperController cardRegistrationController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController genderController;
  final TextEditingController birthdayController;
  final bool isShowPassword;
  final DialogTypes dialogTypes;
  final String errorMessage;
  RegistrationState copyWith({
    bool? isLogin,
    GlobalKey<FormState>? formKeyForLogin,
    GlobalKey<FormState>? formKeyForRegister,
    SwiperController? cardRegistrationController,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    bool? isShowPassword,
    DialogTypes? dialogTypes,
    String? errorMessage,
    TextEditingController? nameController,
    TextEditingController? phoneController,
    TextEditingController? genderController,
    TextEditingController? birthdayController,
  }) {
    return RegistrationState(
      isLogin: isLogin ?? this.isLogin,
      formKeyForLogin: formKeyForLogin ?? this.formKeyForLogin,
      formKeyForRegister: formKeyForRegister ?? this.formKeyForRegister,
      cardRegistrationController:
          cardRegistrationController ?? this.cardRegistrationController,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      isShowPassword: isShowPassword ?? this.isShowPassword,
      dialogTypes: dialogTypes ?? this.dialogTypes,
      errorMessage: errorMessage ?? this.errorMessage,
      nameController: nameController ?? this.nameController,
      phoneController: phoneController ?? this.phoneController,
      genderController: genderController ?? this.genderController,
      birthdayController: birthdayController ?? this.birthdayController,
    );
  }

  @override
  List<Object> get props => [
        isLogin,
        cardRegistrationController,
        emailController,
        passwordController,
        isShowPassword,
        formKeyForLogin,
        formKeyForRegister,
        dialogTypes,
        errorMessage,
        nameController,
        phoneController,
        genderController,
        birthdayController
      ];
}
