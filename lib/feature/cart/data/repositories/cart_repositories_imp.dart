import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/exception.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/core/services/network_info.dart';
import 'package:fashion/feature/cart/data/data/remote_data_source_cart.dart';
import 'package:fashion/feature/cart/domain/entities/cart_entity.dart';
import 'package:fashion/feature/cart/domain/repositories/cart_repositories.dart';

typedef AddDeleteRemove = Future<Unit> Function();

class CartRepositoriesImp implements CartRepositories {
  final RemoteDataSourceCart remoteData;
  final NetworkInfo networkInfo;

  CartRepositoriesImp(this.remoteData, this.networkInfo);

  @override
  Future<Either<Failure, List<CartEntity>>> getCart(int userID) async {
    if (await networkInfo.isConnected) {
      try {
        final cart = await remoteData.getCart(userID);
        return Right(cart);
      } on NoDataFailure {
        return Left(NoDataFailure());
      } on ServerFailure {
        return Left(ServerFailure());
      } catch (e) {
        print(e);
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addOnePiece(
      int producID,
      int price,
      int userID,
      String image,
      String nameEn,
      String nameAr,
      int sizeID,
      int colorID) async {
    return await _addDeleteRemove(() {
      return remoteData.addOnePiece(
        producID,
        price,
        userID,
        image,
        nameEn,
        nameAr,
        sizeID,
        colorID,
      );
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteAllPiece(
      int productID, int userID, int sizeID, int colorID) async {
    return await _addDeleteRemove(() {
      return remoteData.deleteAllPieces(productID, userID, sizeID, colorID);
    });
  }

  @override
  Future<Either<Failure, Unit>> removeOnePiece(
      int productID, int userID, int sizeID, int colorID) async {
    return await _addDeleteRemove(() {
      return remoteData.removeOnPiece(productID, userID, sizeID, colorID);
    });
  }

  Future<Either<Failure, Unit>> _addDeleteRemove(
      AddDeleteRemove fromRemoteData) async {
    if (await networkInfo.isConnected) {
      try {
        await fromRemoteData();
        return const Right(unit);
      } on NoDataFailure {
        return Left(NoDataFailure());
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        print(e);
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
