import 'package:dartz/dartz.dart';
import 'package:fashion/core/services/network_info.dart';
import 'package:fashion/feature/saved/data/data/remote_data_source_saved_product.dart';
import 'package:fashion/feature/saved/domine/entity/saved_product_entity.dart';
import 'package:fashion/feature/saved/domine/repositories/saved_product_repository.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';

typedef FromRemoteData = Future<Unit> Function();

class SavedProductRepositoriesImp implements SavedProductRepository {
  final NetworkInfo networkInfo;
  final RemoteDataSourceSavedProduct remoteDataSourceSavedProduct;
  SavedProductRepositoriesImp(
      this.networkInfo, this.remoteDataSourceSavedProduct);

  @override
  Future<Either<Failure, List<SavedProductEntity>>> getSavedProduct(
      int userID, int page) async {
    if (await networkInfo.isConnected) {
      try {
        final products = await remoteDataSourceSavedProduct.getSavedProduct(
          userID,
          page,
        );
        print(products);
        return Right(products);
      } on NoDataException {
        return Left(NoDataFailure());
      } on ServerException {
        print("(===============================)");
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
  Future<Either<Failure, Unit>> addToSaved(int userID, int productID) async {
    return await _returnFilureOrUnit(() {
      return remoteDataSourceSavedProduct.addToSaved(userID, productID);
    });
  }

  @override
  Future<Either<Failure, Unit>> removeFromSaved(
      int userID, int productID) async {
    return await _returnFilureOrUnit(() {
      return remoteDataSourceSavedProduct.removeFromSaved(userID, productID);
    });
  }

  @override
  Future<Either<Failure, Unit>> removeAllSaved(int userID) async {
    return await _returnFilureOrUnit(() {
      return remoteDataSourceSavedProduct.removeAllSaved(userID);
    });
  }

  Future<Either<Failure, Unit>> _returnFilureOrUnit(
      FromRemoteData remoteData) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteData();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on SomethingNotCorrectExeption {
        return Left(SomethingNotCorrectFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
