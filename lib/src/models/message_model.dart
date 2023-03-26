// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'dart:convert';

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  String? id;
  String? message;
  String? idSender;
  String? idReceiver;
  String? idChat;
  String? status;
  String? url;
  bool? isImage;
  bool? isVideo;
  int? timestamp;

  MessageModel({
    this.id,
    this.message,
    this.idSender,
    this.idReceiver,
    this.idChat,
    this.status,
    this.url,
    this.isImage,
    this.isVideo,
    this.timestamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json["id"],
        message: json["message"],
        idSender: json["id_sender"],
        idReceiver: json["id_receiver"],
        idChat: json["id_chat"],
        status: json["status"],
        url: json["url"],
        isImage: json["is_image"],
        isVideo: json["is_video"],
        timestamp:int.parse(json["timestamp"]) ,
      );

  static List<MessageModel> fromJsonList(List<dynamic> jsonList) {
    
    List<MessageModel> toList = [];

    jsonList.forEach((item) {
      MessageModel message = MessageModel.fromJson(item);
      toList.add(message);
    });

    return toList;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "id_sender": idSender,
        "id_receiver": idReceiver,
        "id_chat": idChat,
        "status": status,
        "url": url,
        "is_image": isImage,
        "is_video": isVideo,
        "timestamp": timestamp,
      };
}
