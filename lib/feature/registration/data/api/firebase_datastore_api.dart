import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/core/constants/app_constants.dart';
import 'package:my_app/data/model/post_model.dart';
import 'package:my_app/feature/registration/data/model/users_app.dart';

import '../model/result_api.dart';

class FirebaseDatastoreApi {
  Future<ResultApi> getData({
    required String collectionName,
    required documentId,
  }) async {
    try {
      var doc =
          FirebaseFirestore.instance.collection(collectionName).doc(documentId);
      var dataResult = await doc.get();
      if (dataResult.exists) {
        return ResultApi(isError: false, value: dataResult.data());
      } else {
        return ResultApi(isError: true, value: 'No data found');
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<ResultApi> deleteData({
    required String collectionName,
    required documentId,
  }) async {
    try {
      var doc =
          FirebaseFirestore.instance.collection(collectionName).doc(documentId);
      await doc.delete();
      return ResultApi(isError: false, value: 'done');
    } catch (e) {
      throw e.toString();
    }
  }

  Future<ResultApi> updateData({
    required String collectionName,
    required documentId,
    required Map<String, dynamic> data,
  }) async {
    try {
      var doc =
          FirebaseFirestore.instance.collection(collectionName).doc(documentId);
      await doc.update(data);
      return ResultApi(isError: false, value: 'done');
    } catch (e) {
      throw e.toString();
    }
  }

  Future<ResultApi> getUserInteraction({
    required String collectionName,
    required List<String> listData,
  }) async {
    try {
      var data = FirebaseFirestore.instance.collection(collectionName);
      var whereData = data.where('userLikeAndComment', whereIn: listData);
      var dataResult = await whereData.get();
      List<UserApp> usersInteraction = [];
      for (var element in dataResult.docs) {
        usersInteraction.add(UserApp.fromJson(element.data()));
      }
      return ResultApi(isError: false, value: usersInteraction);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<ResultApi> getMultiData({
    required String collectionName,
  }) async {
    try {
      var data = FirebaseFirestore.instance.collection(collectionName);
      var dataSorted = data.orderBy(AppConstants.idPost, descending: true);
      var dataResult = await dataSorted.get();
      List<PostModel> posts = [];
      for (var element in dataResult.docs) {
        if (element.exists) {
          posts.add(PostModel.fromJson(element.data()));
        }
      }
      return ResultApi(isError: false, value: posts);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<ResultApi> setData({
    required String collectionName,
    required documentId,
    required Map<String, dynamic> data,
  }) async {
    try {
      var doc =
          FirebaseFirestore.instance.collection(collectionName).doc(documentId);
      await doc.set(data);

      return ResultApi(isError: false, value: doc.id);
    } catch (e) {
      throw e.toString();
    }
  }
}
