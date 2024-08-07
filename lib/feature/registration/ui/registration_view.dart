import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/core/helper/extensions/navigator.dart';
import 'package:my_app/core/routing/routes.dart';
import 'package:my_app/feature/login/ui/screen/login_view.dart';
import 'package:my_app/feature/registration/data/api/firebase_auth_api.dart';
import 'package:my_app/feature/registration/data/api/firebase_datastore_api.dart';
import 'package:my_app/feature/registration/data/repository/auth_repository.dart';
import 'package:my_app/feature/registration/logic/registration_cubit.dart';
import 'package:my_app/feature/signup/ui/signup_view.dart';

import '../../../core/enum/dialog_types.dart';

class RegistrationView extends StatelessWidget {
  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegistrationCubit>(
      create: (context) => RegistrationCubit(
        authenticationRepository: AuthenticationRepository(
          firebaseDatastoreApi: FirebaseDatastoreApi(),
          firebaseAuthApi: FirebaseAuthApi(),
        ),
      ),
      child: Scaffold(
        body: BlocConsumer<RegistrationCubit, RegistrationState>(
          buildWhen: (previous, current) => false,
          listenWhen: (previous, current) =>
              previous.dialogTypes != current.dialogTypes,
          listener: (context, state) async {
            switch (state.dialogTypes) {
              case DialogTypes.loading:
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Loading...'),
                    content: SizedBox(
                        height: 40.h,
                        width: 40.w,
                        child:
                            const Center(child: CircularProgressIndicator())),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Ok'))
                    ],
                  ),
                ).whenComplete(
                    () => context.read<RegistrationCubit>().resetDialog());
                break;
              case DialogTypes.error:
                if (!context.mounted) return;
                context.pop();
                await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Error!'),
                          content: SingleChildScrollView(
                            child: Text(state.errorMessage),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  context.pop();
                                },
                                child: const Text('Ok'))
                          ],
                        )).whenComplete(
                    () => context.read<RegistrationCubit>().resetDialog());
                break;
              case DialogTypes.success:
                if (!context.mounted) return;
                context.pushNamed(Routes.homeScreen);
                break;
              case DialogTypes.showDatePicker:
                if (!context.mounted) return;
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1930),
                        lastDate: DateTime.now())
                    .then((value) => context
                        .read<RegistrationCubit>()
                        .takeDatePicker(date: value));
              default:
            }
          },
          builder: (context, state) {
            return Swiper(
              itemCount: 2,
              autoplay: false,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              controller: state.cardRegistrationController,
              itemBuilder: (context, index) {
                return index == 0 ? const LoginView() : const SignupView();
              },
            );
          },
        ),
      ),
    );
  }
}
