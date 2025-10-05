import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/checkout/domin/repositories/checkout_repositories.dart';

class AddCouponUsecase {
  final CheckoutRepositories checkoutRepositories;
  AddCouponUsecase(this.checkoutRepositories);
  Future<Either<Failure, int>> call(String couponName) async {
    return await checkoutRepositories.addCoupon(couponName);
  }
}
