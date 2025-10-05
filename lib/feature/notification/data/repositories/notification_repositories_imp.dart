import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/exception.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/core/services/network_info.dart';
import 'package:fashion/feature/notification/data/data/local_data_source_notific.dart';
import 'package:fashion/feature/notification/data/data/remote_data_source_notifi.dart';
import 'package:fashion/feature/notification/domain/entiti/notification_entiti.dart';
import 'package:fashion/feature/notification/domain/repositories/notific_repositories.dart';

class NotificationRepositoriesImp implements NotificRepositories {
  final NetworkInfo networkInfo;
  final LocalDataSourceNotification localData;
  final RemoteDataSourceNotification remoteData;
  NotificationRepositoriesImp(
      this.networkInfo, this.localData, this.remoteData);
  @override
  Future<Either<Failure, List<NotificationEntity>>> getAllNotification(
      int userID, int page) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteData.getAllNotification(userID, page);
        localData.cachedNotification(response);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      } on NoDataException {
        return Left(NoDataFailure());
      } catch (_) {
        return Left(ServerFailure());
      }
    } else {
      try {
        final response = await localData.getCachedNotification();
        return Right(response);
      } on EmptyCachException {
        return Left(EmptyCachFailure());
      }
    }
  }

  @override
  Future<Either<Failure, int>> getNumbNotficNotRead(int userID) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteData.getNumbNotificNotRead(userID);
        return Right(response);
      } on NoDataException {
        return Left(NoDataFailure());
      } catch (_) {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> readAllNotification(int userID) async {
    if (await networkInfo.isConnected) {
      try {
        final unit = await remoteData.readAllNotification(userID);
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } catch (_) {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
