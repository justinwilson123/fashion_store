import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion/feature/account/domain/entities/last_message_entity.dart';

class LastMessageModel extends LastMessageEntity {
  const LastMessageModel({
    super.counter,
    required super.imageName,
    required super.nameUser,
    required super.lastMessage,
    required super.senderID,
    required super.time,
    super.timeStamp,
  });
  factory LastMessageModel.fromJson(Map<String, dynamic> json) {
    return LastMessageModel(
      counter: json['counter'] ?? 0,
      imageName: json['imagename'],
      nameUser: json['nameuser'],
      lastMessage: json['lastmessage'],
      senderID: json['senderId'],
      time: DateTime.parse(json['time'].toString()).toLocal(),
      timeStamp: DateTime.parse(json['timestamp'].toString()),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "counter": FieldValue.increment(1),
      "imagename": imageName,
      "nameuser": nameUser,
      "senderId": senderID,
      "lastmessage": lastMessage,
      "time": time.toUtc().toIso8601String(),
      "timestamp": FieldValue.serverTimestamp(),
    };
  }
}
