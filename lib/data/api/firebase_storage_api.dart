import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import '../../feature/registration/data/model/result_api.dart';

class FirebaseStorageApi {
  Future<ResultApi> uploadImageToStorage({
    required BuildContext context,
    required String imagePath,
    required String folderName,
    required String imageName,
  }) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      Reference imageRef = storageRef.child(folderName);
      final spaceRef = imageRef.child(imageName);
      UploadTask uploadTask = spaceRef.putFile(File(imagePath));
      await uploadTask.whenComplete(() => null);
      String imageUrl = await spaceRef.getDownloadURL();
      return ResultApi(isError: false, value: imageUrl);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<ResultApi> deleteImage({
    required BuildContext context,
    required String folderName,
    required int lengthImage,
  }) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      for (int i = 0; i < lengthImage; i++) {
        Reference imageRef = storageRef.child('$folderName/$i.jpg');
        await imageRef.delete();
      }

      return ResultApi(isError: false, value: 'done');
    } catch (e) {
      throw e.toString();
    }
  }
}
