import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/constants/app_constants.dart';
import 'package:my_app/core/enum/dialog_types.dart';
import 'package:my_app/core/helper/app_data/app_data.dart';
import 'package:my_app/data/api/firebase_storage_api.dart';
import 'package:my_app/data/repository/firebase_storage.dart';
import 'package:my_app/feature/registration/data/api/firebase_datastore_api.dart';
import 'package:my_app/feature/registration/data/model/result_api.dart';
import 'package:my_app/feature/registration/data/repository/firebase_database_repo.dart';

import '../../registration/data/model/users_app.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final BuildContext context;
  final UserApp userApp;

  ProfileCubit({
    required this.userApp,
    required this.context,
  }) : super(ProfileState(
          isMyProfile: context.read<AppData>().getUser!.id == userApp.id,
          userApp: userApp,
        ));
  Future<void> updateImageProfile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    emit(state.copyWith(
      dialogTypes: DialogTypes.loading,
    ));
    if (result != null) {
      String imagePath = result.files.first.path!;
      FirebaseStorageRepo firebaseStorageRepo =
          FirebaseStorageRepo(firebaseStorageApi: FirebaseStorageApi());
      ResultApi resultApi = await firebaseStorageRepo.uploadImageToStorage(
        context: context,
        imagePath: imagePath,
        folderName: AppConstants.userCollection,
        imageName: state.userApp.id,
      );
      if (!resultApi.isError) {
        String imageUrl = resultApi.value;
        UserApp userApp = state.userApp.copyWith(image: imageUrl);

        ResultApi result =
            await FirebaseDatabaseRepo(FirebaseDatastoreApi()).uploadData(
          collectionName: AppConstants.userCollection,
          documentId: state.userApp.id,
          dataUpload: userApp.toJson(),
        );
        if (!result.isError) {
          if (!context.mounted) return;
          context.read<AppData>().setUser = userApp;
          emit(state.copyWith(
            dialogTypes: DialogTypes.success,
            userApp: userApp,
          ));
        } else {
          emit(state.copyWith(
            dialogTypes: DialogTypes.error,
            errorMessage: result.value,
          ));
        }
      } else {
        emit(state.copyWith(
          dialogTypes: DialogTypes.error,
          errorMessage: resultApi.value,
        ));
      }
    }
  }

  void resetDialog() {
    emit(state.copyWith(
      dialogTypes: DialogTypes.initial,
      errorMessage: '',
    ));
  }
}
