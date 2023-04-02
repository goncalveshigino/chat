import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  String? id;
  String? idUser1;
  String? idUser2;
  int? timestamp;

  String? nameUser1;
  String? lastnameUser1;
  String? emailUser1;
  String? imageUser1;
  String? phoneUser1;

  String? nameUser2;
  String? lastnameUser2;
  String? emailUser2;
  String? imageUser2;
  String? phoneUser2;

  String? lastMessage;
  int? unReadMessage;
  int? lastMessageTimestamp;

  ChatModel({
    this.id,
    this.idUser1,
    this.idUser2,
    this.timestamp,
    this.nameUser1,
    this.lastnameUser1,
    this.emailUser1,
    this.imageUser1,
    this.phoneUser1,
    this.nameUser2,
    this.lastnameUser2,
    this.emailUser2,
    this.imageUser2,
    this.phoneUser2,
    this.lastMessage,
    this.unReadMessage,
    this.lastMessageTimestamp,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        id: json["id"],
        idUser1: json["id_user1"],
        idUser2: json["id_user2"],
        timestamp: int.parse(json["timestamp"]),
        nameUser1: json["name_user1"],
        lastnameUser1: json["lastname_user1"],
        emailUser1: json["email_user1"],
        imageUser1: json["image_user1"],
        phoneUser1: json["phone_user1"],
        nameUser2: json["name_user2"],
        lastnameUser2: json["lastname_user2"],
        emailUser2: json["email_user2"],
        imageUser2: json["image_user2"],
        phoneUser2: json["phone_user2"],
        lastMessage: json["last_message"],
        unReadMessage: json["unread_message"] != null
            ? int.parse(json["unread_message"])
            : 0,
        lastMessageTimestamp: json["last_message_timestamp"] != null
            ? int.parse(json["last_message_timestamp"])
            : 0
      );

  static List<ChatModel> fromJsonList(List<dynamic> jsonList) {
    List<ChatModel> toList = [];

    for (var item in jsonList) {
      ChatModel chat = ChatModel.fromJson(item);
      toList.add(chat);
    }

    return toList;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user1": idUser1,
        "id_user2": idUser2,
        "timestamp": timestamp,
        "name_user1": nameUser1,
        "lastname_user1": lastnameUser1,
        "email_user1": emailUser1,
        "image_user1": imageUser1,
        "phone_user1": phoneUser1,
        "name_user2": nameUser2,
        "lastname_user2": lastnameUser2,
        "email_user2": emailUser2,
        "image_user2": imageUser2,
        "phone_user2": phoneUser2,
        "last_message": lastMessage,
        "unread_message": unReadMessage, 
        "last_message_timestamp": lastMessageTimestamp
      };
}
