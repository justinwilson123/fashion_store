import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/exception.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/core/services/network_info.dart';
import 'package:fashion/feature/product_details/domain/entity/details_entities.dart';
import 'package:fashion/feature/product_details/domain/entity/reviews_entitiy.dart';
import 'package:fashion/feature/product_details/domain/repositories/product_details_repositories.dart';

import '../data/remote_data_source_product_detailes.dart';

class ProductDetailsRepositoriesImp implements ProductDetailsRepositories {
  final RemoteDataSourceProductDetailes remoteData;
  final NetworkInfo networkInfo;
  ProductDetailsRepositoriesImp(this.networkInfo, this.remoteData);

  @override
  Future<Either<Failure, List<SizedEntity>>> getSizes(int productID) async {
    if (await networkInfo.isConnected) {
      try {
        final sizes = await remoteData.getSizes(productID);
        return Right(sizes);
      } on NoDataException {
        return Left(NoDataFailure());
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
  Future<Either<Failure, List<ColorsEntity>>> getColors(
      int productID, int sizeID) async {
    if (await networkInfo.isConnected) {
      try {
        final colors = await remoteData.getColors(productID, sizeID);
        return Right(colors);
      } on NoDataException {
        return Left(NoDataFailure());
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
  Future<Either<Failure, Unit>> addToCart(
    int producID,
    String price,
    int userID,
    String image,
    String nameEn,
    String nameAr,
    int sizeID,
    int colorID,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteData.addToCart(
          producID,
          price,
          userID,
          image,
          nameEn,
          nameAr,
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

  @override
  Future<Either<Failure, List<CountGroupByRatingEntity>>> getCountGroupRating(
      int productID) async {
    if (await networkInfo.isConnected) {
      try {
        final countGroupRating = await remoteData.countGroupRating(productID);
        return Right(countGroupRating);
      } on NoDataException {
        return Left(NoDataFailure());
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
  Future<Either<Failure, List<ReviewsEntity>>> getReviews(
      int productID, int page) async {
    if (await networkInfo.isConnected) {
      try {
        final reviews = await remoteData.getReviews(productID, page);
        return Right(reviews);
      } on NoDataException {
        return Left(NoDataFailure());
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
