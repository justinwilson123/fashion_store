import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/saved/domine/repositories/saved_product_repository.dart';

class AddToSavedUsecase {
  final SavedProductRepository savedProduct;
  AddToSavedUsecase(this.savedProduct);

  Future<Either<Failure, Unit>> call(int userID, int productID) async {
    return await savedProduct.addToSaved(userID, productID);
  }
}
