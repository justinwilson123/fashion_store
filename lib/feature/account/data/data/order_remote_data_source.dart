import 'package:dartz/dartz.dart';
import 'package:fashion/core/constant/app_links.dart';
import 'package:fashion/core/error/exception.dart';
import 'package:fashion/core/services/crud.dart';
import 'package:fashion/feature/account/data/models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrderOngoing(int userID);
  Future<List<OrderModel>> getOrderCompleted(int userID, int page);
  Future<Unit> ratingProduct(
    int userID,
    int productID,
    String comment,
    int rating,
    int orderID,
    int sizeID,
    int colorID,
  );
  Future<Map<String, dynamic>> getLocation(int locationID);
  Future<Map<String, dynamic>> getDelivery(int deliveryID);
}

class OrderRemoteDataWithHttp implements OrderRemoteDataSource {
  final Crud crud;
  OrderRemoteDataWithHttp(this.crud);
  @override
  Future<List<OrderModel>> getOrderOngoing(int userID) async {
    final data = {
      "userID": userID.toString(),
    };
    final response = await crud.postData(AppLinks.orderOngoingLisnk, data);
    if (response['status'] == "success") {
      List responseList = response["data"] as List;
      List<OrderModel> listOredeModel = responseList
          .map<OrderModel>((json) => OrderModel.fromJson(json))
          .toList();
      return listOredeModel;
    } else if (response['status'] == "failure") {
      throw NoDataException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<OrderModel>> getOrderCompleted(int userID, int page) async {
    final data = {
      "userID": userID.toString(),
      "page": page.toString(),
    };
    final response = await crud.postData(AppLinks.orderCompletedLink, data);
    if (response['status'] == "success") {
      List responseList = response["data"] as List;
      List<OrderModel> listOredeModel = responseList
          .map<OrderModel>((json) => OrderModel.fromJson(json))
          .toList();
      return listOredeModel;
    } else if (response['status'] == "failure") {
      throw NoDataException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> ratingProduct(
    int userID,
    int productID,
    String comment,
    int rating,
    int orderID,
    int sizeID,
    int colorID,
  ) async {
    final data = {
      "userID": userID.toString(),
      "productID": productID.toString(),
      "comment": comment,
      "rating": rating.toString(),
      "orderID": orderID.toString(),
      "sizeID": sizeID.toString(),
      "colorID": colorID.toString(),
    };
    final response = await crud.postData(AppLinks.ratingOrderLink, data);
    if (response['status'] == "success") {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> getLocation(int locationID) async {
    final data = {
      "locationID": locationID.toString(),
    };
    final response = await crud.postData(AppLinks.myLocationLink, data);
    if (response['status'] == "success") {
      Map<String, dynamic> location = response['data'] as Map<String, dynamic>;
      return location;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> getDelivery(int deliveryID) async {
    final data = {
      "deliveryID": deliveryID.toString(),
    };
    final response = await crud.postData(AppLinks.deliveryLink, data);
    if (response['status'] == "success") {
      Map<String, dynamic> delivery = response['data'] as Map<String, dynamic>;
      return delivery;
    } else {
      throw ServerException();
    }
  }
}
