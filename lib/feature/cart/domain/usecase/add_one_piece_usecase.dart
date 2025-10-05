import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/cart/domain/repositories/cart_repositories.dart';

class AddOnePieceUsecase {
  final CartRepositories cartRepositories;
  AddOnePieceUsecase(this.cartRepositories);
  Future<Either<Failure, Unit>> call({
    required int producID,
    required int price,
    required int userID,
    required String image,
    required String nameEn,
    required String nameAr,
    required int sizeID,
    required int colorID,
  }) async {
    return await cartRepositories.addOnePiece(
      producID,
      price,
      userID,
      image,
      nameEn,
      nameAr,
      sizeID,
      colorID,
    );
  }
}
