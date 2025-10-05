import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:fashion/core/class/cached_user_info.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/notification/domain/entiti/grouped_notification.dart';
import 'package:fashion/feature/notification/domain/usercase/get_all_notifi_usecase.dart';
import 'package:fashion/feature/notification/domain/usercase/get_numb_notifi_not_read_usecase.dart';
import 'package:fashion/feature/notification/domain/usercase/read_all_notification_usercase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../../../../core/constant/strings/failure_message.dart';
import '../../../domain/entiti/notification_entiti.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  int page = 0;
  final GetAllNotifiUsecase getAllNotifi;
  final GetNumbNotifiNotReadUsecase notifiNotRead;
  final CachedUserInfo userInfo;
  final ReadAllNotificationUsercase readNotifiction;
  NotificationBloc(
    this.getAllNotifi,
    this.notifiNotRead,
    this.userInfo,
    this.readNotifiction,
  ) : super(NotificationInitial()) {
    on<GetNotificationEvent>(
      (event, emit) async {
        if (state.haseRechedMax) {
          page = 0;
          return;
        }
        page += 1;
        emit(state.copyWith(
          isLoading: true,
          errorMessage: "",
          emptyNotification: false,
        ));
        final user = await userInfo.getUserInfo();
        final either = await getAllNotifi.call(user.userId!, page);
        either.fold(
          (failure) {
            if (failure is EmptyCachFailure) {
              emit(state.copyWith(emptyNotification: true, isLoading: false));
            } else if (failure is NoDataFailure) {
              emit(state.copyWith(
                  haseRechedMax: true, isLoading: false, errorMessage: ""));
            } else {
              emit(state.copyWith(
                  errorMessage: _mapFailureToMessage(failure),
                  isLoading: false));
            }
          },
          (notifications) {
            final grouped = _groupNotifications(notifications);
            if (notifications.length >= 10) {
              emit(state.copyWith(
                notification: List.of(state.notification)..addAll(grouped),
                isLoading: false,
                emptyNotification: false,
              ));
            } else {
              emit(state.copyWith(
                notification: List.of(state.notification)..addAll(grouped),
                isLoading: false,
                emptyNotification: false,
                haseRechedMax: true,
              ));
            }
          },
        );
      },
      transformer: droppable(),
    );
    on<NotificationEvent>((event, emit) async {
      final user = await userInfo.getUserInfo();
      if (event is GetNotificationNotReadEvent) {
        final either = await notifiNotRead.call(user.userId!);
        either.fold((failure) {
          emit(state.copyWith(errorMessage: _mapFailureToMessage(failure)));
        }, (number) {
          emit(state.copyWith(nummberNotRead: number));
        });
      } else if (event is ReadAllNotificationEvent) {
        final either = await readNotifiction.call(user.userId!);
        either.fold(
          (_) {},
          (_) {
            page = 0;

            emit(state.copyWith(
                nummberNotRead: 0, haseRechedMax: false, notification: []));
          },
        );
      }
    });
  }
  String _mapFailureToMessage(Failure failure) {
    if (failure == ServerFailure()) {
      return SERVER_FAILURE_MESSAGE;
    } else if (failure == OffLineFailure()) {
      return OFFLINE_FAILURE_MESSAGE;
    } else {
      return "UnExpected Error , please try again later";
    }
  }

  List<GroupedNotifications> _groupNotifications(
      List<NotificationEntity> notifications) {
    final today = DateTime.now();
    final yesterday = today.subtract(const Duration(days: 1));

    List<NotificationEntity> todayNotifications = [];
    List<NotificationEntity> yesterdayNotifications = [];
    Map<String, List<NotificationEntity>> otherNotifications = {};

    for (var notification in notifications) {
      if (_isSameDay(notification.dateTime, today)) {
        todayNotifications.add(notification);
      } else if (_isSameDay(notification.dateTime, yesterday)) {
        yesterdayNotifications.add(notification);
      } else {
        String dateKey = DateFormat('yyyy-MM-dd').format(notification.dateTime);
        otherNotifications.putIfAbsent(dateKey, () => []).add(notification);
      }
    }
    var otherEntries = otherNotifications.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key));

    List<GroupedNotifications> result = [];

    if (todayNotifications.isNotEmpty) {
      result.add(GroupedNotifications(
        title: "Today",
        notifications: todayNotifications,
      ));
    }

    if (yesterdayNotifications.isNotEmpty) {
      result.add(GroupedNotifications(
        title: "Yesterday",
        notifications: yesterdayNotifications,
      ));
    }

    for (var entry in otherEntries) {
      result.add(GroupedNotifications(
        title: _formatDateHeader(entry.key),
        notifications: entry.value,
      ));
    }

    return result;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _formatDateHeader(String dateString) {
    final date = DateTime.parse(dateString);

    return DateFormat('d MMMM y', 'en').format(date);
  }
}
