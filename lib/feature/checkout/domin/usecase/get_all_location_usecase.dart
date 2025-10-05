import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/checkout/domin/entity/checkout_entities.dart';
import 'package:fashion/feature/checkout/domin/repositories/checkout_repositories.dart';

class GetAllLocationUsecase {
  final CheckoutRepositories checkoutRepositories;
  GetAllLocationUsecase(this.checkoutRepositories);
  Future<Either<Failure, List<LocationEntity>>> call(int userID) async {
    return await checkoutRepositories.getAllLocation(userID);
  }
}
