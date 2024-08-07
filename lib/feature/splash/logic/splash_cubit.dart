import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/constants/app_constants.dart';
import 'package:my_app/core/enum/navigator_splash.dart';
import 'package:my_app/core/helper/app_data/app_data.dart';
import 'package:my_app/feature/registration/data/model/users_app.dart';
import 'package:my_app/feature/registration/data/repository/firebase_database_repo.dart';

import '../../registration/data/api/firebase_datastore_api.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final BuildContext context;
  SplashCubit({required this.context}) : super(const SplashState()) {
    autoLogin();
  }
  Future<void> autoLogin() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    if (firebaseAuth.currentUser != null) {
      FirebaseDatabaseRepo firebaseDatabaseRepo = FirebaseDatabaseRepo(
        FirebaseDatastoreApi(),
      );
      var result = await firebaseDatabaseRepo.getData(
          collectionName: AppConstants.userCollection,
          documentId: firebaseAuth.currentUser!.uid);
      if (result.isError) {
        emit(state.copyWith(navigatorSplash: NavigatorSplash.registration));
      } else {
        emit(state.copyWith(
          navigatorSplash: NavigatorSplash.home,
        ));
        UserApp userApp = UserApp.fromJson(result.value);
        if (!context.mounted) return;
        context.read<AppData>().setUser = userApp;
      }
    } else {
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(navigatorSplash: NavigatorSplash.registration));
    }
  }
}
