import 'package:equatable/equatable.dart';

enum TypeNotification { account, offer, paymante, wallet, newService }

class NotificationEntity extends Equatable {
  final int notifiID;
  final int userNotifiID;
  final String title;
  final String body;
  final String type;
  final String? image;
  final DateTime dateTime;
  final int isRead;

  const NotificationEntity({
    required this.notifiID,
    required this.userNotifiID,
    required this.title,
    required this.body,
    required this.type,
    required this.isRead,
    required this.dateTime,
    this.image,
  });
  @override
  List<Object?> get props => [
        notifiID,
        userNotifiID,
        title,
        body,
        isRead,
        dateTime,
        image,
        type,
      ];
}

// "notifi_id": 1,
//             "user_notifi_id": 1,
//             "title": "account",
//             "body": "your account has been created",
//             "type": "account",
//             "image_notifi": null,
//             "notifi_date": "2025-06-05 14:40:08",
//             "is_read": 0