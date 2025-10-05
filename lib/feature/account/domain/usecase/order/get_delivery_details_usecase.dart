import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/account/domain/repositories/order_repositories.dart';

class GetDeliveryDetailsUsecase {
  final OrderRepositories order;
  GetDeliveryDetailsUsecase(this.order);
  Future<Either<Failure, Map<String, dynamic>>> call(int deliveryID) async {
    return await order.getDelivery(deliveryID);
  }
}
