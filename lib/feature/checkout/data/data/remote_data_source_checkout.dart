import 'package:dartz/dartz.dart';
import 'package:fashion/core/constant/app_links.dart';
import 'package:fashion/core/error/exception.dart';
import 'package:fashion/core/services/crud.dart';
import 'package:fashion/feature/checkout/data/models/card_model.dart';
import 'package:fashion/feature/checkout/data/models/location_model.dart';

abstract class RemoteDataSourceCheckout {
  Future<LocationModel> getDefaultLocation(int userID);
  Future<CardModel> getDefaultCart(int userID);
  Future<List<LocationModel>> getAllLocation(int userID);
  Future<List<CardModel>> getAllCard(int userID);
  Future<Unit> addCard(CardModel card);
  Future<Unit> addLocation(LocationModel location);
  Future<int> addCoupon(String couponName);
  Future<Unit> addOrder(
    int userID,
    int locationID,
    String payment,
    int discount,
    int totalPrice,
  );
}

class RemoteDataCheckOutWithHttp extends RemoteDataSourceCheckout {
  final Crud crud;
  RemoteDataCheckOutWithHttp(this.crud);

  @override
  Future<CardModel> getDefaultCart(int userID) async {
    final data = {
      "userID": userID.toString(),
    };
    final response = await crud.postData(AppLinks.getDefaultCard, data);
    if (response['status'] == "success") {
      final responseMap = response['data'] as Map<String, dynamic>;
      CardModel defaultCard = CardModel.fromJson(responseMap);
      return defaultCard;
    } else if (response['status'] == 'failure') {
      throw NoDataException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<LocationModel> getDefaultLocation(int userID) async {
    final data = {
      "userID": userID.toString(),
    };
    final response = await crud.postData(AppLinks.getDefaultLoction, data);
    if (response['status'] == "success") {
      final responseMap = response['data'] as Map<String, dynamic>;
      LocationModel defaultLocation = LocationModel.fromJson(responseMap);
      return defaultLocation;
    } else if (response['status'] == 'failure') {
      throw NoDataException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<CardModel>> getAllCard(int userID) async {
    final data = {
      "userID": userID.toString(),
    };
    final response = await crud.postData(AppLinks.allCardLink, data);
    if (response['status'] == "success") {
      List responseData = response['data'] as List;
      List<CardModel> listCardModel = responseData
          .map<CardModel>((json) => CardModel.fromJson(json))
          .toList();
      return listCardModel;
    } else if (response['status'] == "failure") {
      throw NoDataException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<LocationModel>> getAllLocation(int userID) async {
    final data = {
      "userID": userID.toString(),
    };
    final response = await crud.postData(AppLinks.allLocationLink, data);
    if (response['status'] == "success") {
      List responseData = response['data'] as List;
      List<LocationModel> listLocationModel = responseData
          .map<LocationModel>((json) => LocationModel.fromJson(json))
          .toList();
      return listLocationModel;
    } else if (response['status'] == "failure") {
      throw NoDataException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addCard(CardModel card) async {
    final data = card.toJson();
    final response = await crud.postData(AppLinks.addCardLink, data);
    if (response["status"] == "success") {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addLocation(LocationModel location) async {
    final data = location.toJson();
    final response = await crud.postData(AppLinks.addLocationLink, data);
    if (response["status"] == "success") {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<int> addCoupon(String couponName) async {
    final data = {
      "couponName": couponName,
    };
    final response = await crud.postData(AppLinks.addCouponLink, data);
    if (response["status"] == "success") {
      int discount = response['data'] as int;
      return discount;
    } else if (response['status'] == "failure") {
      throw NoDataException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addOrder(
    int userID,
    int locationID,
    String payment,
    int discount,
    int totalPrice,
  ) async {
    final data = {
      "user_id": userID.toString(),
      "loactoin_id": locationID.toString(),
      "paymant": payment,
      "discount": discount.toString(),
      "total_price": totalPrice.toString(),
    };
    final response = await crud.postData(AppLinks.addOrderLink, data);
    if (response["status"] == "success") {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
// $user_id        =  filterRequest("user_id");
// $loactoin_id      =  filterRequest("loactoin_id");
// $paymant =  filterRequest("paymant");
// $order_status =  filterRequest("order_status");
// $discount         =  filterRequest("discount");
// $total_price  =  filterRequest("total_price");
