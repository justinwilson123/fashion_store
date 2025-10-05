import 'package:fashion/core/constant/app_links.dart';
import 'package:fashion/core/error/exception.dart';
import '../../../../core/services/crud.dart';
import '../models/all_product_model.dart';
import '../models/categoris_model.dart';

abstract class RemoteDataSourceHome {
  Future<List<CategoreisModel>> getCategoreis();
  Future<List<ProductModel>> getAllProduct(int userID, int page);

  Future<List<ProductModel>> getProduct(int userID, int categoryID, int page);
  Future<String> getMaxPriceAllProduct();
  Future<String> getMaxPriceProduct(int categoryID);
  Future<List<ProductModel>> highLowPriceAllProduct(int userID, int page);
  Future<List<ProductModel>> lowHighPriceAllProduct(int userID, int page);
  Future<List<ProductModel>> rangePriceAllProduct(
    int userID,
    int page,
    int maxPrice,
    int minPrice,
  );
  Future<List<ProductModel>> highLowPriceProduct(
      int catogryID, int userID, int page);
  Future<List<ProductModel>> lowHighPriceProduct(
      int catogryID, int userID, int page);
  Future<List<ProductModel>> rangePriceProduct(
    int catogryID,
    int userID,
    int page,
    int maxPrice,
    int minPrice,
  );
}

class RemoteDataSourceHomeImpHttp implements RemoteDataSourceHome {
  final Crud crud;
  RemoteDataSourceHomeImpHttp(this.crud);

  @override
  Future<List<CategoreisModel>> getCategoreis() async {
    final data = {};
    final response = await crud.postData(AppLinks.categroeisLink, data);
    if (response['status'] == "success") {
      final listData = response['data'] as List;
      final categories =
          listData.map((json) => CategoreisModel.fromJson(json)).toList();
      return categories;
    } else if (response['status'] == "failure") {
      throw NoDataException();
    } else {
      throw ServerException();
    }
  }
  // Price: High - Low

  @override
  Future<List<ProductModel>> getAllProduct(int userID, int page) async {
    final data = {
      "seved_user_id": userID.toString(),
      "page": page.toString(),
    };
    final response = await crud.postData(AppLinks.allProductLink, data);
    return _productFun(response);
  }

  @override
  Future<List<ProductModel>> getProduct(
      int userID, int categoryID, int page) async {
    final data = {
      "product_category_id": categoryID.toString(),
      "user_id": userID.toString(),
      "page": page.toString(),
    };
    final response = await crud.postData(AppLinks.productLink, data);
    return _productFun(response);
  }

  @override
  Future<String> getMaxPriceAllProduct() async {
    final data = {};
    final response = await crud.postData(AppLinks.maxPriceAllProductLink, data);
    if (response['status'] == "success") {
      String maxPrice = response['data'] ?? "100";
      return maxPrice;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> getMaxPriceProduct(int categoryID) async {
    final data = {"product_category_id": categoryID.toString()};
    final response = await crud.postData(AppLinks.maxPriceProductLink, data);
    if (response['status'] == "success") {
      String maxPrice = response['data'] ?? "100";
      return maxPrice;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> highLowPriceAllProduct(
      int userID, int page) async {
    final data = {
      "seved_user_id": userID.toString(),
      "page": page.toString(),
    };
    final response =
        await crud.postData(AppLinks.highLowPriceAllProductLink, data);
    return _productFun(response);
  }

  @override
  Future<List<ProductModel>> lowHighPriceAllProduct(
      int userID, int page) async {
    final data = {
      "seved_user_id": userID.toString(),
      "page": page.toString(),
    };
    final response =
        await crud.postData(AppLinks.lowHighPriceAllProductLink, data);
    return _productFun(response);
  }

  @override
  Future<List<ProductModel>> rangePriceAllProduct(
      int userID, int page, int maxPrice, int minPrice) async {
    final data = {
      "seved_user_id": userID.toString(),
      "page": page.toString(),
      "maxPrice": maxPrice.toString(),
      "minPrice": minPrice.toString(),
    };
    final response =
        await crud.postData(AppLinks.rangePriceAllProductLink, data);
    return _productFun(response);
  }

  @override
  Future<List<ProductModel>> highLowPriceProduct(
      int catogryID, int userID, int page) async {
    final data = {
      "product_category_id": catogryID.toString(),
      "user_id": userID.toString(),
      "page": page.toString(),
    };
    final response =
        await crud.postData(AppLinks.highLowPriceProductLink, data);
    return _productFun(response);
  }

  @override
  Future<List<ProductModel>> lowHighPriceProduct(
      int catogryID, int userID, int page) async {
    final data = {
      "product_category_id": catogryID.toString(),
      "user_id": userID.toString(),
      "page": page.toString(),
    };
    final response =
        await crud.postData(AppLinks.lowHighPriceProductLink, data);
    return _productFun(response);
  }

  @override
  Future<List<ProductModel>> rangePriceProduct(
      int catogryID, int userID, int page, int maxPrice, int minPrice) async {
    final data = {
      "product_category_id": catogryID.toString(),
      "user_id": userID.toString(),
      "page": page.toString(),
      "maxPrice": maxPrice.toString(),
      "minPrice": minPrice.toString(),
    };
    final response = await crud.postData(AppLinks.rangePriceProductLink, data);
    return _productFun(response);
  }

  List<ProductModel> _productFun(Map<dynamic, dynamic> response) {
    if (response["status"] == "success") {
      final listData = response["data"] as List;
      final product =
          listData.map((json) => ProductModel.fromJson(json)).toList();
      return product;
    } else if (response['status'] == "failure") {
      throw NoDataException();
    } else {
      throw ServerException();
    }
  }
}
