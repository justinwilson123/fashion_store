import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/home/domain/entiti/discove_entities.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<CategoryEntiti>>> getCategory();
  Future<Either<Failure, List<ProductEntity>>> getAllProduct(
    int userID,
    int page,
  );

  Future<Either<Failure, List<ProductEntity>>> getProduct(
    int userID,
    int categoryId,
    int page,
  );
  Future<Either<Failure, String>> getMaxPriceAllProduct();
  Future<Either<Failure, String>> getMaxPriceProduct(int categoryID);
  Future<Either<Failure, List<ProductEntity>>> lowHighPriceAllProduct(
    int userID,
    int page,
  );
  Future<Either<Failure, List<ProductEntity>>> highLowPriceAllProduct(
    int userID,
    int page,
  );
  Future<Either<Failure, List<ProductEntity>>> rangePriceAllProduct(
    int userID,
    int page,
    int maxPrice,
    int minPrice,
  );
  Future<Either<Failure, List<ProductEntity>>> lowHighPriceProduct(
    int catogryID,
    int userID,
    int page,
  );
  Future<Either<Failure, List<ProductEntity>>> highLowPriceProduct(
    int catogryID,
    int userID,
    int page,
  );
  Future<Either<Failure, List<ProductEntity>>> rangPriceProduct(
    int catogryID,
    int userID,
    int page,
    int maxPrice,
    int minPrice,
  );
}
