import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/result_api.dart';

class FirebaseAuthApi {
  Future<ResultApi> signUp({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return ResultApi(isError: false, value: credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      return ResultApi(isError: true, value: signUpError(error: e.code));
    } catch (e) {
      return ResultApi(isError: true, value: e.toString());
    }
  }

  Future<ResultApi> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return ResultApi(isError: false, value: credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      return ResultApi(isError: true, value: logInError(error: e.code));
    } catch (e) {
      throw e.toString();
    }
  }

  String logInError({required String error}) {
    switch (error) {
      case 'invalid-email' || 'invalid-credential':
        return 'Email is not valid or badly formatted.';
      case 'user-disabled':
        return 'This user has been disabled. Please contact support for help.';
      case 'user-not-found':
        return 'Email is not found, please create an account.';
      case 'wrong-password':
        return 'Incorrect password, please try again.';
      default:
        return 'Error occurred, please try again.';
    }
  }

  String signUpError({required String error}) {
    switch (error) {
      case 'invalid-email':
        return 'Email is not valid or badly formatted.';
      case 'user-disabled':
        return 'This user has been disabled. Please contact support for help.';
      case 'email-already-in-use':
        return 'An account already exists for that email.';
      case 'operation-not-allowed':
        return 'Operation is not allowed.  Please contact support.';
      case 'weak-password':
        return 'Please enter a stronger password.';
      default:
        return 'Error occurred, please try again.';
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw e.toString();
    }
  }
}
