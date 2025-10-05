import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import '../repositories/saved_product_repository.dart';

class RemoveFromSavedUsercase {
  final SavedProductRepository savedProduct;
  RemoveFromSavedUsercase(this.savedProduct);

  Future<Either<Failure, Unit>> call(int userID, int productID) async {
    return await savedProduct.removeFromSaved(userID, productID);
  }
}
