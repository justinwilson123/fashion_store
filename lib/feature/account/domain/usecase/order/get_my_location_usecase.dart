import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/account/domain/repositories/order_repositories.dart';

class GetMyLocationUsercase {
  final OrderRepositories order;
  GetMyLocationUsercase(this.order);
  Future<Either<Failure, Map<String, dynamic>>> call(int locationID) async {
    return await order.getMyLocation(locationID);
  }
}
