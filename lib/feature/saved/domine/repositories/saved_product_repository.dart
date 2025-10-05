import 'package:dartz/dartz.dart';
import 'package:fashion/feature/saved/domine/entity/saved_product_entity.dart';

import '../../../../core/error/failure.dart';

abstract class SavedProductRepository {
  Future<Either<Failure, Unit>> addToSaved(int userID, int productID);
  Future<Either<Failure, Unit>> removeFromSaved(int userID, int productID);
  Future<Either<Failure, List<SavedProductEntity>>> getSavedProduct(
      int userID, int page);
  Future<Either<Failure, Unit>> removeAllSaved(int userID);
}
