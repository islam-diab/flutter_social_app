import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/constants/app_constants.dart';
import 'package:my_app/core/enum/dialog_types.dart';
import 'package:my_app/core/helper/app_data/app_data.dart';
import 'package:my_app/data/api/firebase_storage_api.dart';
import 'package:my_app/data/model/post_model.dart';
import 'package:my_app/data/repository/firebase_storage.dart';
import 'package:my_app/feature/registration/data/model/result_api.dart';
import 'package:my_app/feature/registration/data/repository/firebase_database_repo.dart';

import '../../../registration/data/api/firebase_datastore_api.dart';

part 'add_new_post_state.dart';

class AddNewPostCubit extends Cubit<AddNewPostState> {
  AddNewPostCubit()
      : super(AddNewPostState(postController: TextEditingController()));

  void pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );
    if (result != null) {
      List<String> files = result.paths.map((path) => path!).toList();
      emit(state.copyWith(
        images: List.from(files),
      ));
    }
  }

  Future<void> addPost(BuildContext context) async {
    emit(state.copyWith(dialogTypes: DialogTypes.loading));
    FirebaseStorageRepo firebaseStorageRepo = FirebaseStorageRepo(
      firebaseStorageApi: FirebaseStorageApi(),
    );
    List<String> uriImage = [];
    DateTime dateTime = DateTime.now();
    String idUser = context.read<AppData>().getUser!.id;
    String idPost = dateTime.millisecondsSinceEpoch.toString() +
        idUser.substring(idUser.length - 5, idUser.length);

    for (var image in state.images) {
      ResultApi resultApi = await firebaseStorageRepo.uploadImageToStorage(
        imagePath: image,
        context: context,
        folderName: idPost,
        imageName: '${state.images.indexOf(image)}.jpg',
      );
      if (!resultApi.isError) {
        String uri = resultApi.value;
        uriImage.add(uri);
      }
    }
    final String content = state.postController.text.trim();
    PostModel postModel = PostModel(
      comments: [],
      images: uriImage,
      datePost: '${dateTime.year}-${dateTime.month}-${dateTime.day}',
      idDate: dateTime.millisecondsSinceEpoch,
      contentPost: content,
      idUserPost: idUser,
      whoLikes: [],
      idPost: idPost,
    );
    FirebaseDatabaseRepo firebaseDatabaseRepo = FirebaseDatabaseRepo(
      FirebaseDatastoreApi(),
    );
    ResultApi resultApi = await firebaseDatabaseRepo.uploadData(
      collectionName: AppConstants.postCollection,
      documentId: idPost,
      dataUpload: postModel.toJson(),
    );
    if (resultApi.isError) {
      emit(state.copyWith(
          dialogTypes: DialogTypes.error, errorMessage: resultApi.value));
    } else {
      emit(state.copyWith(dialogTypes: DialogTypes.success));
    }
  }

  void resetDialog() {
    emit(state.copyWith(dialogTypes: DialogTypes.initial));
  }
}
