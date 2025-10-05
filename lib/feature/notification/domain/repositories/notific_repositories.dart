import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/notification/domain/entiti/notification_entiti.dart';

abstract class NotificRepositories {
  Future<Either<Failure, List<NotificationEntity>>> getAllNotification(
      int userID, int page);
  Future<Either<Failure, int>> getNumbNotficNotRead(int userID);
  Future<Either<Failure, Unit>> readAllNotification(int userID);
}
