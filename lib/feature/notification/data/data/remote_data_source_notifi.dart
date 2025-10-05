import 'package:dartz/dartz.dart';

import '../../../../core/constant/app_links.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/services/crud.dart';

import '../models/notifiaction_modal.dart';

abstract class RemoteDataSourceNotification {
  Future<List<NotifiactionModal>> getAllNotification(int userID, int page);
  Future<int> getNumbNotificNotRead(int userID);
  Future<Unit> readAllNotification(int userID);
}

class RemoteDateSourceNotifiHttp implements RemoteDataSourceNotification {
  final Crud crud;
  RemoteDateSourceNotifiHttp(this.crud);
  @override
  Future<List<NotifiactionModal>> getAllNotification(
      int userID, int page) async {
    final data = {
      "user_notifi_id": userID.toString(),
      "page": page.toString(),
    };
    final response = await crud.postData(AppLinks.notificationLinks, data);
    if (response["status"] == "success") {
      final List responseData = response['data'] as List;
      final List<NotifiactionModal> notifications = responseData
          .map<NotifiactionModal>(
              (notification) => NotifiactionModal.fromJson(notification))
          .toList();
      return notifications;
    } else if (response["status"] == "failure") {
      throw NoDataException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<int> getNumbNotificNotRead(int userID) async {
    final data = {
      "user_notifi_id": userID.toString(),
    };
    final response = await crud.postData(AppLinks.notificNotRead, data);
    if (response['status'] == "success") {
      final respnseData = response["data"] as int;
      return respnseData;
    } else {
      throw NoDataException();
    }
  }

  @override
  Future<Unit> readAllNotification(int userID) async {
    final data = {
      "user_notifi_id": userID.toString(),
    };
    final response = await crud.postData(AppLinks.readNotificationLink, data);
    if (response['status'] == "success") {
      return Future.value(unit);
    } else if (response['status'] == "failure") {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
