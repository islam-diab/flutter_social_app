import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/constants/app_constants.dart';
import 'package:my_app/core/enum/dialog_types.dart';
import 'package:my_app/data/model/post_model.dart';
import 'package:my_app/feature/registration/data/model/result_api.dart';
import 'package:my_app/feature/registration/data/repository/firebase_database_repo.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit({required this.firebaseDatabaseRepo}) : super(const PostState()) {
    getListPost(
      isRefresh: true,
    );
  }
  final FirebaseDatabaseRepo firebaseDatabaseRepo;

  Future<void> getListPost({
    bool isRefresh = false,
  }) async {
    if (!isRefresh) {
      emit(state.copyWith(postState: DialogTypes.loading));
    }
    ResultApi resultApi = await firebaseDatabaseRepo.getMultiData(
        collectionName: AppConstants.postCollection);
    if (resultApi.isError) {
      emit(state.copyWith(
        postState: DialogTypes.error,
        error: resultApi.value,
      ));
    } else {
      emit(state.copyWith(
        posts: List.from(resultApi.value),
        postState: DialogTypes.success,
      ));
    }
  }

  Future<void> deletePost(String idPost) async {
    List<PostModel> posts = List.from(state.posts);

    posts.removeWhere((element) => element.idPost == idPost);
    emit(state.copyWith(posts: posts));
  }
}
