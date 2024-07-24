

import 'dart:convert';

AuthModel authModelFromJson(Map<String, dynamic>  str) => AuthModel.fromJson(str);

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  bool? success;
  String? message;
  String? accessToken;

  AuthModel({
    this.success,
    this.message,
    this.accessToken,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    success: json["success"],
    message: json["message"],
    accessToken: json["access_token"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "access_token": accessToken,
  };
}
