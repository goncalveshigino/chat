import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? id;
  String? email;
  String? firstname;
  String? lastname;
  String? phone;
  String? password;
  String? sessionToken;
  String? image;
  String? isVailable;

  UserModel({
    this.id,
    this.email,
    this.firstname,
    this.lastname,
    this.phone,
    this.password,
    this.sessionToken,
    this.image,
    this.isVailable,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'firstname': firstname,
        'lastname': lastname,
        'phone': phone,
        'password': password,
        'sessionToken': sessionToken,
        'image': image,
        'isVailable': isVailable,
      };

  factory UserModel.fromJson(Map<String, dynamic> map) => UserModel(
        id: map['id'],
        email: map['email'],
        firstname: map['firstname'],
        lastname: map['lastname'],
        phone: map['phone'],
        password: map['password'],
        sessionToken: map['sessionToken'],
        image: map['image'],
        isVailable: map['isVailable'],
      );
}
