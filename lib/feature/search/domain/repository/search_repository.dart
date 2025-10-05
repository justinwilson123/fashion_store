import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/search/domain/entity/search_entity.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<SearchEntity>>> getResult(String name);
  Future<Either<Failure, List<SearchEntity>>> getCachResult();
  Future<Either<Failure, Unit>> cachedResult(List<SearchEntity> results);
  Future<Either<Failure, Unit>> removeAllCachedResult();
  Future<Either<Failure, Unit>> removeOneCahedResult(
    List<SearchEntity> results,
  );
}
