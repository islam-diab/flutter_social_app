import 'package:flutter/cupertino.dart';
import 'package:my_app/core/helper/function_help.dart';
import 'package:my_app/feature/registration/data/model/result_api.dart';

import '../api/firebase_storage_api.dart';

class FirebaseStorageRepo {
  final FirebaseStorageApi firebaseStorageApi;
  FirebaseStorageRepo({
    required this.firebaseStorageApi,
  });
  Future<ResultApi> uploadImageToStorage({
    required BuildContext context,
    required String imagePath,
    required String folderName,
    required String imageName,
  }) async {
    if (await FunctionHelp.isConnectedNetwork()) {
      try {
        if (!context.mounted) {
          return ResultApi(isError: true, value: 'Error in repository');
        }
        final ResultApi resultApi =
            await firebaseStorageApi.uploadImageToStorage(
                context: context,
                imagePath: imagePath,
                folderName: folderName,
                imageName: imageName);
        return resultApi;
      } catch (e) {
        throw ResultApi(isError: true, value: e.toString());
      }
    } else {
      return ResultApi(isError: true, value: 'No internet connection');
    }
  }

  Future<ResultApi> deleteImage({
    required BuildContext context,
    required String folderName,
    required int lengthImage,
  }) async {
    if (await FunctionHelp.isConnectedNetwork()) {
      try {
        if (!context.mounted) {
          return ResultApi(isError: true, value: 'Error in repository');
        }
        final ResultApi resultApi = await firebaseStorageApi.deleteImage(
            context: context, folderName: folderName, lengthImage: lengthImage);
        return resultApi;
      } catch (e) {
        throw ResultApi(isError: true, value: e.toString());
      }
    } else {
      return ResultApi(isError: true, value: 'No internet connection');
    }
  }
}
