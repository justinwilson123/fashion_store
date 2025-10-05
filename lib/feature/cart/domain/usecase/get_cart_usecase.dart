import 'package:dartz/dartz.dart';
import 'package:fashion/feature/cart/domain/repositories/cart_repositories.dart';

import '../../../../core/error/failure.dart';
import '../entities/cart_entity.dart';

class GetCartUsecase {
  final CartRepositories cartRepositories;
  GetCartUsecase(this.cartRepositories);
  Future<Either<Failure, List<CartEntity>>> call(int userID) async {
    return await cartRepositories.getCart(userID);
  }
}
