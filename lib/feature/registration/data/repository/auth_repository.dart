import 'package:flutter/cupertino.dart';
import 'package:my_app/core/constants/app_constants.dart';
import 'package:my_app/feature/registration/data/model/result_api.dart';
import 'package:my_app/feature/registration/data/model/users_app.dart';

import '../../../../core/helper/function_help.dart';
import '../api/firebase_auth_api.dart';
import '../api/firebase_datastore_api.dart';

class AuthenticationRepository {
  final FirebaseAuthApi firebaseAuthApi;
  final FirebaseDatastoreApi firebaseDatastoreApi;

  AuthenticationRepository({
    required this.firebaseAuthApi,
    required this.firebaseDatastoreApi,
  });

  Future<ResultApi> logInWithEmailAndPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      if (await FunctionHelp.isConnectedNetwork()) {
        if (!context.mounted) {
          return ResultApi(isError: false, value: 'Error context');
        }
        ResultApi result = await firebaseAuthApi.logInWithEmailAndPassword(
            email: email, password: password);

        ResultApi resultApi = await firebaseDatastoreApi.getData(
          collectionName: AppConstants.userCollection,
          documentId: result.value,
        );

        if (resultApi.isError) {
          return resultApi;
        } else {
          Map<String, dynamic> dataUser = resultApi.value;
          UserApp userApp = UserApp.fromJson(dataUser);
          return ResultApi(isError: false, value: userApp);
        }
      } else {
        return ResultApi(isError: true, value: 'No internet access');
      }
    } catch (e) {
      firebaseAuthApi.signOut();
      return ResultApi(isError: true, value: e.toString());
    }
  }

  Future<ResultApi> signUp({
    required BuildContext context,
    required String birthday,
    required String email,
    required String name,
    required String password,
    required String phone,
  }) async {
    try {
      if (await FunctionHelp.isConnectedNetwork()) {
        if (!context.mounted) return ResultApi(isError: false, value: '');
        ResultApi result = await firebaseAuthApi.signUp(
            context: context, email: email, password: password);
        String userId = result.value;
        UserApp userApp = UserApp(
          id: userId,
          birthday: birthday,
          email: email,
          name: name,
          password: password,
          phone: phone,
        );
        ResultApi resultApi = await firebaseDatastoreApi.setData(
            collectionName: AppConstants.userCollection,
            documentId: userId,
            data: userApp.toJson());

        if (resultApi.isError) {
          return resultApi;
        } else {
          return ResultApi(isError: false, value: userApp);
        }
      } else {
        return ResultApi(isError: true, value: 'No internet access');
      }
    } catch (e) {
      firebaseAuthApi.signOut();
      return ResultApi(isError: true, value: e.toString());
    }
  }
}
