import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';

import '../repositories/notific_repositories.dart';

class ReadAllNotificationUsercase {
  final NotificRepositories repositories;
  ReadAllNotificationUsercase(this.repositories);

  Future<Either<Failure, Unit>> call(int userID) async {
    return await repositories.readAllNotification(userID);
  }
}
