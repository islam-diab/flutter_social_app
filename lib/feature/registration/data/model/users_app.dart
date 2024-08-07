import 'package:json_annotation/json_annotation.dart';

part 'users_app.g.dart';
  
@JsonSerializable()
class UserApp {
  final String id;
  final String name;
  final String email;
  final String? image;
  final String password;
  final String phone;
  final String birthday;

  UserApp({
    required this.id,
    required this.name,
    this.image,
    required this.email,
    required this.password,
    required this.phone,
    required this.birthday,
  });

  UserApp copyWith({
    String? name,
    String? image,
  }) =>
      UserApp(
        name: name ?? this.name,
        image: image ?? this.image,
        id: id,
        email: email,
        password: password,
        phone: phone,
        birthday: birthday,
      );
  factory UserApp.fromJson(Map<String, dynamic> json) =>
      _$UserAppFromJson(json);
  Map<String, dynamic> toJson() => _$UserAppToJson(this);
}
