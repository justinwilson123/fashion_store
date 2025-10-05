import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/exception.dart';
import 'package:fashion/feature/home/data/models/all_product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/categoris_model.dart';

abstract class LocalDataSource {
  Future<List<ProductModel>> getCachedProducts();
  Future<Unit> cachedProducts(List<ProductModel> productModel);
  Future<Unit> cachedCategories(List<CategoreisModel> categoryModel);
  Future<List<CategoreisModel>> getCachedCategories();
}

class LocalDataSourceSpfLite implements LocalDataSource {
  @override
  Future<Unit> cachedProducts(List<ProductModel> productModels) {
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getCachedProducts() {
    throw UnimplementedError();
  }

  @override
  Future<Unit> cachedCategories(List<CategoreisModel> categoroiesModel) {
    throw UnimplementedError();
  }

  @override
  Future<List<CategoreisModel>> getCachedCategories() {
    throw UnimplementedError();
  }
}

const CASCHED_PRODUCT = "CASCHED_PRODUCT";
const CACHED_CATEGORY = "CACHED_CATEGORY";

class LocalDetaSourceSharedPref implements LocalDataSource {
  final SharedPreferences sharedPreferences;
  LocalDetaSourceSharedPref(this.sharedPreferences);
  @override
  Future<Unit> cachedProducts(List<ProductModel> productModels) {
    List productModelToJson = productModels
        .map<Map<String, dynamic>>((productModel) => productModel.toJson())
        .toList();
    sharedPreferences.setString(
        CASCHED_PRODUCT, jsonEncode(productModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<ProductModel>> getCachedProducts() {
    final jsonString = sharedPreferences.getString(CASCHED_PRODUCT);
    if (jsonString != null) {
      List decodeJson = jsonDecode(jsonString);
      List<ProductModel> jsonToProductModel = decodeJson
          .map<ProductModel>(
              (jsonProductModul) => ProductModel.fromJson(jsonProductModul))
          .toList();
      return Future.value(jsonToProductModel);
    } else {
      throw EmptyCachException();
    }
  }

  @override
  Future<Unit> cachedCategories(List<CategoreisModel> categoriesModel) {
    List categoriesToJson =
        categoriesModel.map((categoryModel) => categoryModel.toJson()).toList();
    sharedPreferences.setString(CACHED_CATEGORY, jsonEncode(categoriesToJson));
    return Future.value(unit);
  }

  @override
  Future<List<CategoreisModel>> getCachedCategories() {
    final response = sharedPreferences.getString(CACHED_CATEGORY);
    if (response != null) {
      List decodeResponse = jsonDecode(response);
      List<CategoreisModel> listCategoriesModel = decodeResponse
          .map<CategoreisModel>(
              (category) => CategoreisModel.fromJson(category))
          .toList();
      return Future.value(listCategoriesModel);
    } else {
      throw EmptyCachException();
    }
  }
}
