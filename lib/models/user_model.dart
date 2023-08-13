// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String id;
  String? image;
  String name;
  String email;
  String phone;
  String password;

  UserModel({
    required this.id,
    this.image,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  UserModel copyWith({
    String? id,
    String? image,
    String? name,
    String? email,
    String? phone,
    String? password,
  }) =>
      UserModel(
        id: id ?? this.id,
        image: image ?? this.image,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        password: password ?? this.password,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
      };
}
