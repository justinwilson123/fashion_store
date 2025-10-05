import 'package:equatable/equatable.dart';

class LastMessageEntity extends Equatable {
  final int counter;
  final String imageName;
  final String lastMessage;
  final String nameUser;
  final String senderID;
  final DateTime time;
  final DateTime? timeStamp;

  const LastMessageEntity({
    this.counter = 0,
    required this.imageName,
    required this.nameUser,
    required this.lastMessage,
    required this.senderID,
    required this.time,
    this.timeStamp,
  });

  @override
  List<Object?> get props => [
        counter,
        imageName,
        nameUser,
        lastMessage,
        senderID,
        time,
        timeStamp,
      ];
}
