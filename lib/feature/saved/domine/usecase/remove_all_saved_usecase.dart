import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/saved/domine/repositories/saved_product_repository.dart';

class RemoveAllSavedUsecase {
  final SavedProductRepository savedProduct;
  RemoveAllSavedUsecase(this.savedProduct);
  Future<Either<Failure, Unit>> call(int userID) async {
    return await savedProduct.removeAllSaved(userID);
  }
}
