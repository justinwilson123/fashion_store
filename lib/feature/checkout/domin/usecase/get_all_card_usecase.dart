import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/checkout/domin/entity/checkout_entities.dart';
import 'package:fashion/feature/checkout/domin/repositories/checkout_repositories.dart';

class GetAllCardUsecase {
  final CheckoutRepositories checkoutRepositories;
  GetAllCardUsecase(this.checkoutRepositories);
  Future<Either<Failure, List<CardEntity>>> call(int userID) async {
    return await checkoutRepositories.getAllCard(userID);
  }
}
