import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/saved/domine/entity/saved_product_entity.dart';
import 'package:fashion/feature/saved/domine/repositories/saved_product_repository.dart';

class GetSavedProductUsecase {
  final SavedProductRepository savedProduct;
  GetSavedProductUsecase(this.savedProduct);
  Future<Either<Failure, List<SavedProductEntity>>> call(
      int userID, int page) async {
    return await savedProduct.getSavedProduct(userID, page);
  }
}
