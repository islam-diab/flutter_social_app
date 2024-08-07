// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_app.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserApp _$UserAppFromJson(Map<String, dynamic> json) => UserApp(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String?,
      email: json['email'] as String,
      password: json['password'] as String,
      phone: json['phone'] as String,
      birthday: json['birthday'] as String,
    );

Map<String, dynamic> _$UserAppToJson(UserApp instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'image': instance.image,
      'password': instance.password,
      'phone': instance.phone,
      'birthday': instance.birthday,
    };
