import 'package:my_app/feature/registration/data/api/firebase_datastore_api.dart';
import 'package:my_app/feature/registration/data/model/result_api.dart';

import '../../../../core/helper/function_help.dart';

class FirebaseDatabaseRepo {
  final FirebaseDatastoreApi firebaseDatastoreApi;
  FirebaseDatabaseRepo(this.firebaseDatastoreApi);
  Future<ResultApi> getData(
      {required String collectionName, required String documentId}) async {
    if (await FunctionHelp.isConnectedNetwork()) {
      try {
        final ResultApi resultApi = await firebaseDatastoreApi.getData(
            collectionName: collectionName, documentId: documentId);
        return resultApi;
      } catch (e) {
        return ResultApi(isError: true, value: e.toString());
      }
    } else {
      return ResultApi(isError: true, value: 'No internet access');
    }
  }

  Future<ResultApi> deleteData(
      {required String collectionName, required String documentId}) async {
    if (await FunctionHelp.isConnectedNetwork()) {
      try {
        final ResultApi resultApi = await firebaseDatastoreApi.deleteData(
            collectionName: collectionName, documentId: documentId);
        return resultApi;
      } catch (e) {
        return ResultApi(isError: true, value: e.toString());
      }
    } else {
      return ResultApi(isError: true, value: 'No internet access');
    }
  }

  Future<ResultApi> updateData({
    required String collectionName,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    if (await FunctionHelp.isConnectedNetwork()) {
      try {
        final ResultApi resultApi = await firebaseDatastoreApi.updateData(
            collectionName: collectionName, documentId: documentId, data: data);
        return resultApi;
      } catch (e) {
        return ResultApi(isError: true, value: e.toString());
      }
    } else {
      return ResultApi(isError: true, value: 'No internet access');
    }
  }

  Future<ResultApi> getUserInteraction({
    required String collectionName,
    required List<String> listData,
  }) async {
    if (await FunctionHelp.isConnectedNetwork()) {
      try {
        final ResultApi resultApi =
            await firebaseDatastoreApi.getUserInteraction(
                collectionName: collectionName, listData: listData);
        return resultApi;
      } catch (e) {
        return ResultApi(isError: true, value: e.toString());
      }
    } else {
      return ResultApi(isError: true, value: 'No internet access');
    }
  }

  Future<ResultApi> getMultiData({
    required String collectionName,
  }) async {
    if (await FunctionHelp.isConnectedNetwork()) {
      try {
        final ResultApi resultApi = await firebaseDatastoreApi.getMultiData(
            collectionName: collectionName);
        return resultApi;
      } catch (e) {
        return ResultApi(isError: true, value: e.toString());
      }
    } else {
      return ResultApi(isError: true, value: 'No internet access');
    }
  }

  Future<ResultApi> uploadData({
    required String collectionName,
    required String documentId,
    required Map<String, dynamic> dataUpload,
  }) async {
    if (await FunctionHelp.isConnectedNetwork()) {
      try {
        final ResultApi resultApi = await firebaseDatastoreApi.setData(
            collectionName: collectionName,
            documentId: documentId,
            data: dataUpload);

        return resultApi;
      } catch (e) {
        return ResultApi(isError: true, value: e.toString());
      }
    } else {
      return ResultApi(isError: true, value: 'No internet access');
    }
  }
}
