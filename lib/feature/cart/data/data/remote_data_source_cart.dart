import 'package:dartz/dartz.dart';
import 'package:fashion/core/constant/app_links.dart';
import 'package:fashion/core/error/exception.dart';
import 'package:fashion/core/services/crud.dart';
import 'package:fashion/feature/cart/data/models/cart_model.dart';

abstract class RemoteDataSourceCart {
  Future<List<CartModel>> getCart(int userID);
  Future<Unit> removeOnPiece(
      int productID, int userID, int sizeID, int colorID);
  Future<Unit> deleteAllPieces(
      int productID, int userID, int sizeID, int colorID);
  Future<Unit> addOnePiece(
    int producID,
    int price,
    int userID,
    String image,
    String nameEn,
    String nameAr,
    int sizeID,
    int colorID,
  );
}

class RemoteDataSourceCartWithHttp implements RemoteDataSourceCart {
  final Crud crud;
  RemoteDataSourceCartWithHttp(this.crud);
  @override
  Future<List<CartModel>> getCart(int userID) async {
    final data = {
      "userID": userID.toString(),
    };
    final response = await crud.postData(AppLinks.getCartLink, data);
    print(response);
    if (response['status'] == "success") {
      List responseData = response['data'];
      List<CartModel> cart = responseData
          .map<CartModel>((json) => CartModel.fromJson(json))
          .toList();
      return cart;
    } else if (response['status'] == "failure") {
      throw NoDataException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addOnePiece(
    int producID,
    int price,
    int userID,
    String image,
    String nameEn,
    String nameAr,
    int sizeID,
    int colorID,
  ) async {
    final data = {
      "cart_product_id": producID.toString(),
      "product_price": price.toString(),
      "cart_user_id": userID.toString(),
      "item_image_name": image,
      "product_name_en": nameEn,
      "product_name_ar": nameAr,
      "size_product_id": sizeID.toString(),
      "color_product_id": colorID.toString(),
    };
    final response = await crud.postData(AppLinks.addOnePieceLink, data);
    return _unitOrException(response);
  }

  @override
  Future<Unit> deleteAllPieces(
      int productID, int userID, int sizeID, int colorID) async {
    final data = {
      "productID": productID.toString(),
      "userID": userID.toString(),
      'sizeID': sizeID.toString(),
      "colorID": colorID.toString(),
    };
    final response = await crud.postData(AppLinks.deleteAllPieceLink, data);
    return _unitOrException(response);
  }

  @override
  Future<Unit> removeOnPiece(
      int productID, int userID, int sizeID, int colorID) async {
    final data = {
      "productID": productID.toString(),
      "userID": userID.toString(),
      'sizeID': sizeID.toString(),
      "colorID": colorID.toString(),
    };
    final response = await crud.postData(AppLinks.removeOnePieceLink, data);
    return _unitOrException(response);
  }

  Unit _unitOrException(Map<dynamic, dynamic> response) {
    if (response["status"] == "success") {
      return unit;
    } else if (response['status'] == "failure") {
      throw NoDataException();
    } else {
      throw ServerException();
    }
  }
}
