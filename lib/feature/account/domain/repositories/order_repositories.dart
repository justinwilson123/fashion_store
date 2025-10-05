import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/account/domain/entities/order_entity.dart';

abstract class OrderRepositories {
  Future<Either<Failure, List<OrderEntity>>> getOrderOngoin(int userID);
  Future<Either<Failure, List<OrderEntity>>> getOrderCompleted(
      int userID, int page);
  Future<Either<Failure, Unit>> ratingProduct(
    int userID,
    int productID,
    String comment,
    int rating,
    int orderID,
    int sizeID,
    int colorID,
  );
  Future<Either<Failure, Map<String, dynamic>>> getMyLocation(int locationID);
  Future<Either<Failure, Map<String, dynamic>>> getDelivery(int deliveryID);
}
