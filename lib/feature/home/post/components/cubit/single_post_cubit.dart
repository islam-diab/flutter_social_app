import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/helper/app_data/app_data.dart';
import 'package:my_app/data/api/firebase_storage_api.dart';
import 'package:my_app/data/model/comment_model.dart';
import 'package:my_app/data/model/post_model.dart';
import 'package:my_app/feature/home/post/cubit/post_cubit.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../data/repository/firebase_storage.dart';
import '../../../../registration/data/model/result_api.dart';
import '../../../../registration/data/model/users_app.dart';
import '../../../../registration/data/repository/firebase_database_repo.dart';

part 'single_post_state.dart';

class SinglePostCubit extends Cubit<SinglePostState> {
  final BuildContext context;
  final FirebaseDatabaseRepo firebaseDatabaseRepo;
  final GlobalKey<ScaffoldState> scaffoldKey;
  SinglePostCubit({
    required this.context,
    required PostModel postModel,
    required this.firebaseDatabaseRepo,
    required this.scaffoldKey,
  }) : super(SinglePostState(
          postData: postModel,
          commentController: TextEditingController(),
        )) {
    initData();
  }

  Future<void> initData() async {
    bool isLike =
        state.postData.whoLikes.contains(context.read<AppData>().getUser!.id);
    Set<String> userId = Set.from(state.postData.whoLikes);
    List<String> userIdComment =
        state.postData.comments.map((e) => e.userId).toList();
    userId.addAll(userIdComment);
    ResultApi resultApi = await firebaseDatabaseRepo.getUserInteraction(
      collectionName: AppConstants.userCollection,
      listData: List.from(userId),
    );
    Map<String, UserApp> userInteraction = {};
    if (!resultApi.isError) {
      List<UserApp> users = List.from(resultApi.value);
      for (var element in users) {
        userInteraction[element.id] = element;
      }
    }
    UserApp? userApp = await getUserData();
    userInteraction[context.read<AppData>().getUser!.id] =
        context.read<AppData>().getUser!;
    emit(state.copyWith(
      userApp: userApp,
      isLikePost: isLike,
      userInteraction: userInteraction,
    ));
  }

  Future<UserApp?> getUserData() async {
    ResultApi resultApi = await firebaseDatabaseRepo.getData(
        collectionName: AppConstants.userCollection,
        documentId: state.postData.idUserPost);
    if (!resultApi.isError) {
      return UserApp.fromJson(resultApi.value);
    }
    return null;
  }

  Future<void> likePost(bool isLikePost) async {
    List<String> whoLiked = List.from(state.postData.whoLikes);
    if (isLikePost) {
      whoLiked.remove(context.read<AppData>().getUser!.id);
    } else {
      whoLiked.add(context.read<AppData>().getUser!.id);
    }
    PostModel postModel = state.postData.copy(
      whoLikes: List.from(whoLiked),
    );
    emit(state.copyWith(
      isLikePost: !state.isLikePost,
      postData: postModel,
    ));
    ResultApi resultApi = await firebaseDatabaseRepo.uploadData(
      collectionName: AppConstants.postCollection,
      documentId: state.postData.idPost,
      dataUpload: postModel.toJson(),
    );
    if (resultApi.isError) {
      throw resultApi.value;
    }
  }

  Future<void> addComments() async {
    List<CommentModel> comments = List.from(state.postData.comments);
    CommentModel commentModel = CommentModel(
        commentContent: state.commentController.text.trim(),
        userId: context.read<AppData>().getUser!.id);
    comments.add(commentModel);
    PostModel postModel = state.postData.copy(
      comments: List.from(comments),
    );
    emit(state.copyWith(
      postData: postModel,
    ));
    state.commentController.clear();
    ResultApi result = await firebaseDatabaseRepo.uploadData(
      collectionName: AppConstants.postCollection,
      documentId: state.postData.idPost,
      dataUpload: postModel.toJson(),
    );
    if (result.isError) {}
  }

  Future<void> deletePost() async {
    final idPost = state.postData.idPost;
    FirebaseStorageRepo firebaseStorageRepo =
        FirebaseStorageRepo(firebaseStorageApi: FirebaseStorageApi());
    ResultApi resultApi = await firebaseStorageRepo.deleteImage(
      context: context,
      folderName: idPost,
      lengthImage: state.postData.images.length,
    );
    if (!resultApi.isError) {
      await firebaseDatabaseRepo.deleteData(
        collectionName: AppConstants.postCollection,
        documentId: idPost,
      );
    }
    context.read<PostCubit>().deletePost(idPost);
  }

  Future<void> editPost() async {
    final idPost = state.postData.idPost;
    firebaseDatabaseRepo.updateData(
      collectionName: AppConstants.postCollection,
      documentId: idPost,
      data: state.postData.toJson(),
    );
  }
}
