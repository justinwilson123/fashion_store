import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/core/services/network_info.dart';
import 'package:fashion/feature/account/data/data/order_remote_data_source.dart';
import 'package:fashion/feature/account/data/models/order_model.dart';
import 'package:fashion/feature/account/domain/entities/order_entity.dart';
import 'package:fashion/feature/account/domain/repositories/order_repositories.dart';

import '../../../../core/error/exception.dart';

typedef GetOrderFromRemote = Future<List<OrderModel>> Function();

class OrderRepositoriesImp implements OrderRepositories {
  final NetworkInfo networkInfo;
  final OrderRemoteDataSource orderRemoteData;

  OrderRepositoriesImp(this.networkInfo, this.orderRemoteData);

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrderOngoin(int userID) async {
    return await _getOrder(() {
      return orderRemoteData.getOrderOngoing(userID);
    });
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrderCompleted(
      int userID, int page) async {
    return await _getOrder(() {
      return orderRemoteData.getOrderCompleted(userID, page);
    });
  }

  @override
  Future<Either<Failure, Unit>> ratingProduct(
    int userID,
    int productID,
    String comment,
    int rating,
    int orderID,
    int sizeID,
    int colorID,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        await orderRemoteData.ratingProduct(
          userID,
          productID,
          comment,
          rating,
          orderID,
          sizeID,
          colorID,
        );
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } catch (_) {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  Future<Either<Failure, List<OrderModel>>> _getOrder(
      GetOrderFromRemote getOrder) async {
    if (await networkInfo.isConnected) {
      try {
        final order = await getOrder();

        return Right(order);
      } on ServerException {
        return Left(ServerFailure());
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
  Future<Either<Failure, Map<String, dynamic>>> getDelivery(
      int deliveryID) async {
    if (await networkInfo.isConnected) {
      try {
        final delivery = await orderRemoteData.getDelivery(deliveryID);
        return Right(delivery);
      } on ServerException {
        return Left(ServerFailure());
      } catch (_) {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getMyLocation(
      int locationID) async {
    if (await networkInfo.isConnected) {
      try {
        final location = await orderRemoteData.getLocation(locationID);
        return Right(location);
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
