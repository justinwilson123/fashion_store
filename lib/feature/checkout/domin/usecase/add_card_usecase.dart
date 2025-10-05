import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/checkout/domin/entity/checkout_entities.dart';
import 'package:fashion/feature/checkout/domin/repositories/checkout_repositories.dart';

class AddCardUsecase {
  final CheckoutRepositories checkout;
  AddCardUsecase(this.checkout);
  Future<Either<Failure, Unit>> call(CardEntity card) async {
    return await checkout.addCard(card);
  }
}
