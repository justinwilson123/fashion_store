import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/checkout/domin/entity/checkout_entities.dart';
import 'package:fashion/feature/checkout/domin/repositories/checkout_repositories.dart';

class AddLocationUsecase {
  final CheckoutRepositories checkout;
  AddLocationUsecase(this.checkout);
  Future<Either<Failure, Unit>> call(LocationEntity location) async {
    return await checkout.addLocation(location);
  }
}
