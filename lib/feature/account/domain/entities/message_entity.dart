import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final int? id;
  final String senderId;
  final String receiverId;
  final String message;
  final String type;
  final DateTime timeStamp;
  final String chatId;

  const MessageEntity({
    this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.type,
    required this.chatId,
    required this.timeStamp,
  });
  @override
  List<Object?> get props => [
    senderId,
    receiverId,
    message,
    type,
    chatId,
    timeStamp,
  ];
}
