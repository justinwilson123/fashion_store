import 'package:dartz/dartz.dart';
import 'package:fashion/feature/account/domain/repositories/order_repositories.dart';

import '../../../../../core/error/failure.dart';

class RatingOrderUsecase {
  final OrderRepositories orderRepositories;
  RatingOrderUsecase(this.orderRepositories);
  Future<Either<Failure, Unit>> call(
    int userID,
    int productID,
    String comment,
    int rating,
    int orderID,
    int sizeID,
    int colorID,
  ) async {
    return await orderRepositories.ratingProduct(
      userID,
      productID,
      comment,
      rating,
      orderID,
      sizeID,
      colorID,
    );
  }
}
