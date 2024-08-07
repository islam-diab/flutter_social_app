// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      comments: (json['comments'] as List<dynamic>)
          .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      contentPost: json['contentPost'] as String,
      idUserPost: json['idUserPost'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      whoLikes:
          (json['whoLikes'] as List<dynamic>).map((e) => e as String).toList(),
      idPost: json['idPost'] as String,
      datePost: json['datePost'] as String,
      idDate: (json['idDate'] as num).toInt(),
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'idUserPost': instance.idUserPost,
      'images': instance.images,
      'contentPost': instance.contentPost,
      'whoLikes': instance.whoLikes,
      'comments': instance.comments.map((e) => e.toJson()).toList(),
      'idPost': instance.idPost,
      'datePost': instance.datePost,
      'idDate': instance.idDate,
    };
