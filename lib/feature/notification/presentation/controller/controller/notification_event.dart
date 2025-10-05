part of 'notification_bloc.dart';

sealed class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class GetNotificationEvent extends NotificationEvent {
  const GetNotificationEvent();
  @override
  List<Object> get props => [];
}

class GetNotificationNotReadEvent extends NotificationEvent {
  const GetNotificationNotReadEvent();
  @override
  List<Object> get props => [];
}

class ReadAllNotificationEvent extends NotificationEvent {
  const ReadAllNotificationEvent();
  @override
  List<Object> get props => [];
}
