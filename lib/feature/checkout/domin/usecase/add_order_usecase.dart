import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/checkout/domin/repositories/checkout_repositories.dart';

class AddOrderUsecase {
  final CheckoutRepositories checkoutRepositories;
  AddOrderUsecase(this.checkoutRepositories);
  Future<Either<Failure, Unit>> call(
    int userID,
    int locationID,
    String payment,
    int discount,
    int totalPrice,
  ) async {
    return await checkoutRepositories.addOrder(
      userID,
      locationID,
      payment,
      discount,
      totalPrice,
    );
  }
}
