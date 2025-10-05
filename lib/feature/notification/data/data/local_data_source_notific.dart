import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/exception.dart';
import 'package:fashion/feature/notification/data/models/notifiaction_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSourceNotification {
  Future<List<NotifiactionModal>> getCachedNotification();
  Future<Unit> cachedNotification(List<NotifiactionModal> notifiModel);
}

const CACHE_NOTIFI = "CACHE_NOTIFI";

class LocalDataSourceNotifiSharedPrefer implements LocalDataSourceNotification {
  final SharedPreferences sharedPreferences;
  LocalDataSourceNotifiSharedPrefer(this.sharedPreferences);
  @override
  Future<Unit> cachedNotification(List<NotifiactionModal> notifiModel) {
    List notifiToJson = notifiModel
        .map<Map<String, dynamic>>((notifi) => notifi.toJosn())
        .toList();
    sharedPreferences.setString(CACHE_NOTIFI, jsonEncode(notifiToJson));
    return Future.value(unit);
  }

  @override
  Future<List<NotifiactionModal>> getCachedNotification() {
    final notifiString = sharedPreferences.getString(CACHE_NOTIFI);
    if (notifiString != null) {
      List decodeNotifi = jsonDecode(notifiString);
      List<NotifiactionModal> notifications = decodeNotifi
          .map<NotifiactionModal>(
              (notifi) => NotifiactionModal.fromJson(notifi))
          .toList();
      return Future.value(notifications);
    } else {
      throw EmptyCachException();
    }
  }
}
