import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';

import '../entity/checkout_entities.dart';

abstract class CheckoutRepositories {
  Future<Either<Failure, LocationEntity>> getDefaultLocation(int userID);
  Future<Either<Failure, CardEntity>> getDefaultCard(int userID);
  Future<Either<Failure, List<LocationEntity>>> getAllLocation(int userID);
  Future<Either<Failure, List<CardEntity>>> getAllCard(int userID);
  Future<Either<Failure, Unit>> addCard(CardEntity card);
  Future<Either<Failure, Unit>> addLocation(LocationEntity location);
  Future<Either<Failure, int>> addCoupon(String couponName);
  Future<Either<Failure, Unit>> addOrder(
    int userID,
    int locationID,
    String payment,
    int discount,
    int totalPrice,
  );
}


// "user_id"         => $user_id,
//     "loactoin_id"       => $loactoin_id,
//     "paymant"  => $paymant,
//     "order_status"  => $order_status,
//     "delivery_id"  => $delivery_id,
//     "discount"         => $discount,
//     "total_price"          => $total_price,