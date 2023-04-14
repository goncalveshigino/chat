// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? id;
  String? email;
  String? firstname;
  String? lastname;
  String? phone;
  String? image;
  String? password;
  String? sessionToken;
  String? isAvailable;
  String? notificationToken;

  UserModel({
    this.id,
    this.email,
    this.firstname,
    this.lastname,
    this.phone,
    this.image,
    this.password,
    this.sessionToken,
    this.isAvailable,
    this.notificationToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        email: json["email"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        phone: json["phone"],
        image: json["image"],
        password: json["password"],
        sessionToken: json["session_token"],
        isAvailable: json["is_available"],
        notificationToken: json["notification_token"],
      );

  static List<UserModel> fromJsonList(List<dynamic> jsonList) {
    List<UserModel> toList = [];

    for (var item in jsonList) {
      UserModel user = UserModel.fromJson(item);
      toList.add(user);
    }

    //  jsonList.forEach((item) {
    //   UserModel user = UserModel.fromJson(item);
    //   toList.add(user);
    // });

    return toList;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "firstname": firstname,
        "lastname": lastname,
        "phone": phone,
        "image": image,
        "password": password,
        "session_token": sessionToken,
        "is_available": isAvailable,
        "notification_token": notificationToken,
      };
}
