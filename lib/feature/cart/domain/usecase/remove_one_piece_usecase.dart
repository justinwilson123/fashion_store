import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/cart/domain/repositories/cart_repositories.dart';

class RemoveOnePieceUsecase {
  final CartRepositories cartRepositories;
  RemoveOnePieceUsecase(this.cartRepositories);
  Future<Either<Failure, Unit>> call(
      int productID, int userID, int sizeID, int colorID) async {
    return await cartRepositories.removeOnePiece(
        productID, userID, sizeID, colorID);
  }
}
