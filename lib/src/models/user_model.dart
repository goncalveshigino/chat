import 'dart:convert';


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


  Map<String, dynamic> toMap() {
    return {
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
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
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

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
