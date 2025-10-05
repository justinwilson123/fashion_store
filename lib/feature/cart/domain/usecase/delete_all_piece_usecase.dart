import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/cart/domain/repositories/cart_repositories.dart';

class DeleteAllPieceUsecase {
  final CartRepositories cartRepositories;
  DeleteAllPieceUsecase(this.cartRepositories);
  Future<Either<Failure, Unit>> call(
      int productID, int userID, int sizeID, int colorID) async {
    return await cartRepositories.deleteAllPiece(
        productID, userID, sizeID, colorID);
  }
}
