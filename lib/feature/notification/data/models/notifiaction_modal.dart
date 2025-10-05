import 'package:fashion/feature/notification/domain/entiti/notification_entiti.dart';

class NotifiactionModal extends NotificationEntity {
  const NotifiactionModal({
    required super.notifiID,
    required super.userNotifiID,
    required super.title,
    required super.body,
    required super.type,
    required super.isRead,
    super.image,
    required super.dateTime,
  });

  factory NotifiactionModal.fromJson(Map<String, dynamic> json) {
    return NotifiactionModal(
      notifiID: json['notifi_id'],
      userNotifiID: json['user_notifi_id'],
      title: json['title'],
      body: json['body'],
      type: json['type'],
      image: json['image_notifi'] ?? "impty",
      isRead: json['is_read'],
      dateTime: DateTime.parse(json['notifi_date']),
    );
  }

  Map<String, dynamic> toJosn() {
    return {
      "notifi_id": notifiID,
      "user_notifi_id": userNotifiID,
      "title": title,
      "body": body,
      "type": type,
      "image_notifi": image,
      "notifi_date": dateTime.toIso8601String(),
      "is_read": isRead,
    };
  }
}

// "notifi_id": 1,
//             "user_notifi_id": 1,
//             "title": "account",
//             "body": "your account has been created",
//             "type": "account",
//             "image_notifi": null,
//             "notifi_date": "2025-06-05 14:40:08",
//             "is_read": 0