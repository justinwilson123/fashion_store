import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/account/domain/entities/order_entity.dart';
import 'package:fashion/feature/account/domain/repositories/order_repositories.dart';

class GetOrederOngoingUsecase {
  final OrderRepositories order;
  GetOrederOngoingUsecase(this.order);
  Future<Either<Failure, List<OrderEntity>>> call(int userID) async {
    return await order.getOrderOngoin(userID);
  }
}
