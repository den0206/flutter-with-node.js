// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:client_side/src/model/role.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
    this.image,
    this.sessionToken,
    this.roles,
  });

  String id;
  String name;
  String lastName;
  String email;
  String phone;
  String password;
  String? image;
  String? sessionToken;
  List<Role>? roles;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] is int ? json["id"].toString() : json["id"],
        name: json["name"],
        lastName: json["lastname"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        image: json["image"],
        sessionToken: json["session_token"],
        roles: json["roles"] == null
            ? []
            : List<Role>.from(
                json["roles"].map((model) => Role.fromJson(model)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastname": lastName,
        "email": email,
        "phone": phone,
        "password": password,
        "image": image,
        "session_token": sessionToken,
        "roles": roles
      };
}
