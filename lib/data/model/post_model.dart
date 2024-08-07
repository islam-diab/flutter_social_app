import 'package:json_annotation/json_annotation.dart';

import 'comment_model.dart';

part 'post_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PostModel {
  final String idUserPost;
  final List<String> images;
  final String contentPost;
  final List<String> whoLikes;
  final List<CommentModel> comments;
  final String idPost;
  final String datePost;
  final int idDate;
  PostModel({
    required this.comments,
    required this.contentPost,
    required this.idUserPost,
    required this.images,
    required this.whoLikes,
    required this.idPost,
    required this.datePost,
    required this.idDate,
  });
  PostModel copy({
    List<CommentModel>? comments,
    List<String>? whoLikes,
    String? contentPost,
  }) =>
      PostModel(
        comments: comments ?? this.comments,
        contentPost: contentPost ?? this.contentPost,
        datePost: datePost,
        idDate: idDate,
        idPost: idPost,
        idUserPost: idUserPost,
        images: images,
        whoLikes: whoLikes ?? this.whoLikes,
      );
  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
