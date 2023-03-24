

import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {

    String? id;
    String? idUser1;
    String? idUser2;
    int?    timestamp;

    ChatModel({
         this.id,
         this.idUser1,
         this.idUser2,
         this.timestamp,
    });

  

    factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        id: json["id"],
        idUser1: json["id_user1"],
        idUser2: json["id_user2"],
        timestamp: json["timestamp"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_user1": idUser1,
        "id_user2": idUser2,
        "timestamp": timestamp,
    };
}
