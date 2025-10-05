import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/cart_entity.dart';

abstract class CartRepositories {
  Future<Either<Failure, List<CartEntity>>> getCart(int userID);
  Future<Either<Failure, Unit>> removeOnePiece(
      int productID, int userID, int sizeID, int colorID);
  Future<Either<Failure, Unit>> deleteAllPiece(
      int productID, int userID, int sizeID, int colorID);
  Future<Either<Failure, Unit>> addOnePiece(
    int producID,
    int price,
    int userID,
    String image,
    String nameEn,
    String nameAr,
    int sizeID,
    int colorID,
  );
}
