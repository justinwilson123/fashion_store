import 'package:fashion/feature/notification/domain/entiti/notification_entiti.dart';

class GroupedNotifications {
  final String title;
  final List<NotificationEntity> notifications;

  GroupedNotifications({
    required this.title,
    required this.notifications,
  });
}
