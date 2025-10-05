import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/notification/domain/repositories/notific_repositories.dart';

class GetNumbNotifiNotReadUsecase {
  final NotificRepositories notificRepositories;
  GetNumbNotifiNotReadUsecase(this.notificRepositories);

  Future<Either<Failure, int>> call(int userID) async {
    return await notificRepositories.getNumbNotficNotRead(userID);
  }
}
