part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  final bool isLoading;
  final List<GroupedNotifications> notification;
  final String errorMessage;
  final int nummberNotRead;
  final bool emptyNotification;
  final bool haseRechedMax;
  const NotificationState({
    this.errorMessage = "",
    this.isLoading = false,
    this.notification = const [],
    this.nummberNotRead = 0,
    this.emptyNotification = false,
    this.haseRechedMax = false,
  });

  NotificationState copyWith(
      {bool? isLoading,
      List<GroupedNotifications>? notification,
      int? nummberNotRead,
      bool? emptyNotification,
      bool? haseRechedMax,
      String? errorMessage}) {
    return NotificationState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      notification: notification ?? this.notification,
      haseRechedMax: haseRechedMax ?? this.haseRechedMax,
      emptyNotification: emptyNotification ?? this.emptyNotification,
      nummberNotRead: nummberNotRead ?? this.nummberNotRead,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        errorMessage,
        notification,
        nummberNotRead,
        emptyNotification,
        haseRechedMax,
      ];
}

final class NotificationInitial extends NotificationState {}
