import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/notification/domain/entiti/notification_entiti.dart';
import 'package:fashion/feature/notification/domain/repositories/notific_repositories.dart';

class GetAllNotifiUsecase {
  final NotificRepositories notificRepositories;
  GetAllNotifiUsecase(this.notificRepositories);

  Future<Either<Failure, List<NotificationEntity>>> call(
      int userID, int page) async {
    return await notificRepositories.getAllNotification(userID, page);
  }
}
