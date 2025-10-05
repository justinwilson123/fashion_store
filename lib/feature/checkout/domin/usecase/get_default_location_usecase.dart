import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/checkout/domin/entity/checkout_entities.dart';
import 'package:fashion/feature/checkout/domin/repositories/checkout_repositories.dart';

class GetDefaultLocationUsecase {
  final CheckoutRepositories checkout;
  GetDefaultLocationUsecase(this.checkout);
  Future<Either<Failure, LocationEntity>> call(int userID) async {
    return await checkout.getDefaultLocation(userID);
  }
}
