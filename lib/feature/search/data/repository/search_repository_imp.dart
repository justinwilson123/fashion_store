import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/exception.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/core/services/network_info.dart';
import 'package:fashion/feature/search/data/data/search_locale_data_source.dart';
import 'package:fashion/feature/search/data/data/search_remote_data_source.dart';
import 'package:fashion/feature/search/data/model/search_model.dart';
import 'package:fashion/feature/search/domain/entity/search_entity.dart';
import 'package:fashion/feature/search/domain/repository/search_repository.dart';

class SearchRepositoryImp implements SearchRepository {
  final NetworkInfo networkInfo;
  final SearchLocaleDataSource searchLocaleDataSource;
  final SearchRemoteDataSource searchRemoteDataSource;
  SearchRepositoryImp(
    this.networkInfo,
    this.searchLocaleDataSource,
    this.searchRemoteDataSource,
  );
  @override
  Future<Either<Failure, Unit>> cachedResult(List<SearchEntity> results) async {
    final listSearchModel = results
        .map(
          (result) => SearchModel(
            productId: result.productId,
            productCategoryId: result.productCategoryId,
            nameEn: result.nameEn,
            nameAr: result.nameAr,
            descriptionEn: result.descriptionEn,
            descriptionAr: result.descriptionAr,
            productPrice: result.productPrice,
            productImage: result.productImage,
            productDiscount: result.productDiscount,
            productActive: result.productActive,
            favorite: result.favorite,
            countRating: result.countRating,
            avgRating: result.avgRating,
            review: result.review,
          ),
        )
        .toList();
    try {
      await searchLocaleDataSource.cachedResult(listSearchModel);
      return Right(unit);
    } catch (_) {
      return Left(UnExpactedFailure());
    }
  }

  @override
  Future<Either<Failure, List<SearchEntity>>> getCachResult() async {
    try {
      final result = await searchLocaleDataSource.getCachedResult();
      return Right(result);
    } on EmptyCachException {
      return Left(EmptyCachFailure());
    } catch (_) {
      return Left(UnExpactedFailure());
    }
  }

  @override
  Future<Either<Failure, List<SearchEntity>>> getResult(String name) async {
    try {
      final result = await searchRemoteDataSource.getResult(name);
      return Right(result);
    } on NoDataException {
      return Left(NoDataFailure());
    } on ServerException {
      return Left(ServerFailure());
    } catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> removeAllCachedResult() async {
    try {
      await searchLocaleDataSource.cachedResult([]);
      return Right(unit);
    } catch (_) {
      return Left(UnExpactedFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> removeOneCahedResult(
    List<SearchEntity> results,
  ) async {
    final listSearchModel = results
        .map(
          (result) => SearchModel(
            productId: result.productId,
            productCategoryId: result.productCategoryId,
            nameEn: result.nameEn,
            nameAr: result.nameAr,
            descriptionEn: result.descriptionEn,
            descriptionAr: result.descriptionAr,
            productPrice: result.productPrice,
            productImage: result.productImage,
            productDiscount: result.productDiscount,
            productActive: result.productActive,
            favorite: result.favorite,
            countRating: result.countRating,
            avgRating: result.avgRating,
            review: result.review,
          ),
        )
        .toList();
    try {
      await searchLocaleDataSource.cachedResult(listSearchModel);
      return Right(unit);
    } catch (_) {
      return Left(UnExpactedFailure());
    }
  }
}
