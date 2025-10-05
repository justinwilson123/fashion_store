import 'package:fashion/feature/account/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    super.id,
    required super.senderId,
    required super.receiverId,
    required super.message,
    required super.type,
    required super.chatId,
    required super.timeStamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      message: json['message'] ?? '',
      type: json['type'] ?? 'text',
      senderId: json['sender_id'] ?? '',
      receiverId: json['receiver_id'] ?? '',
      chatId: json['chat_id'] ?? '',
      timeStamp: DateTime.parse(
        json['timestamp'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'type': type,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'chat_id': chatId,
      'timestamp': timeStamp.toIso8601String(),
    };
  }
}
