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
    );

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
    };
}
