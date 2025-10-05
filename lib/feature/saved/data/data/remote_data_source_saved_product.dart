import 'package:dartz/dartz.dart';
import 'package:fashion/feature/saved/data/models/saved_product_model.dart';

import '../../../../core/constant/app_links.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/services/crud.dart';

abstract class RemoteDataSourceSavedProduct {
  Future<Unit> addToSaved(int userID, int productID);
  Future<Unit> removeFromSaved(int userID, int productID);
  Future<List<SavedProductModel>> getSavedProduct(int userID, int page);
  Future<Unit> removeAllSaved(int userID);
}

class RemotDataSavedProductWithHttp implements RemoteDataSourceSavedProduct {
  final Crud crud;
  RemotDataSavedProductWithHttp(this.crud);

  @override
  Future<List<SavedProductModel>> getSavedProduct(int userID, int page) async {
    final data = {
      "seved_user_id": userID.toString(),
      "page": page.toString(),
    };
    final response = await crud.postData(AppLinks.getSavedProductLink, data);
    print(response);
    if (response['status'] == "success") {
      List products = response['data'] as List;
      List<SavedProductModel> productsModel = products
          .map((product) => SavedProductModel.fromJson(product))
          .toList();
      return (productsModel);
    } else if (response['status'] == "failure") {
      throw NoDataException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addToSaved(int userID, int productID) async {
    final data = {
      "seved_user_id": userID.toString(),
      "saved_product_id": productID.toString(),
    };
    final response = await crud.postData(AppLinks.addToSavedLink, data);
    return _returnUnit(response);
  }

  @override
  Future<Unit> removeFromSaved(int userID, int productID) async {
    final data = {
      "seved_user_id": userID.toString(),
      "saved_product_id": productID.toString(),
    };
    final response = await crud.postData(AppLinks.removeFromSavedLink, data);
    return _returnUnit(response);
  }

  @override
  Future<Unit> removeAllSaved(int userID) async {
    final data = {
      "seved_user_id": userID.toString(),
    };

    final response = await crud.postData(AppLinks.removeAllSavedLink, data);
    return _returnUnit(response);
  }

  Future<Unit> _returnUnit(Map<dynamic, dynamic> response) {
    if (response['status'] == "success") {
      return Future.value(unit);
    } else if (response['status'] == "failure") {
      throw SomethingNotCorrectExeption();
    } else {
      throw ServerException();
    }
  }
}
