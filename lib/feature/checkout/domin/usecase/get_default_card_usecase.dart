import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/checkout/domin/entity/checkout_entities.dart';
import 'package:fashion/feature/checkout/domin/repositories/checkout_repositories.dart';

class GetDefaultCardUsecase {
  final CheckoutRepositories checkout;
  GetDefaultCardUsecase(this.checkout);
  Future<Either<Failure, CardEntity>> call(int userID) async {
    return await checkout.getDefaultCard(userID);
  }
}
