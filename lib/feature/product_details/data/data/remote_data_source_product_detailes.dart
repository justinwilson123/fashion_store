import 'package:dartz/dartz.dart';
import 'package:fashion/core/constant/app_links.dart';
import 'package:fashion/core/error/exception.dart';
import 'package:fashion/core/services/crud.dart';
import 'package:fashion/feature/product_details/data/models/colors_model.dart';
import 'package:fashion/feature/product_details/data/models/size_model.dart';

import '../models/count_group_rating_model.dart';
import '../models/reviews_model.dart';

abstract class RemoteDataSourceProductDetailes {
  Future<List<SizesModel>> getSizes(int productID);
  Future<List<ColorsModel>> getColors(int productID, int sizeID);
  Future<Unit> addToCart(
    int producID,
    String price,
    int userID,
    String image,
    String nameEn,
    String nameAr,
    int sizeID,
    int colorID,
  );
  Future<List<CountGroupRatingModel>> countGroupRating(int productID);
  Future<List<ReviewsModel>> getReviews(int productID, int page);
}

class RemoteDataProductDetailsWithHttp
    implements RemoteDataSourceProductDetailes {
  final Crud crud;
  RemoteDataProductDetailsWithHttp(this.crud);

  @override
  Future<List<SizesModel>> getSizes(int productID) async {
    final data = {
      "product_id": productID.toString(),
    };
    final response = await crud.postData(AppLinks.sizesProductLink, data);
    if (response['status'] == "success") {
      List sizeList = response['data'] as List;
      List<SizesModel> listSizedModel = sizeList
          .map<SizesModel>((json) => SizesModel.fromJson(json))
          .toList();
      return listSizedModel;
    } else if (response['status'] == "failure") {
      throw NoDataException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ColorsModel>> getColors(int productID, int sizeID) async {
    final data = {
      "product_id": productID.toString(),
      "sized_id": sizeID.toString(),
    };
    final response = await crud.postData(AppLinks.colorsProductLink, data);
    if (response['status'] == "success") {
      List dataList = response['data'] as List;
      List<ColorsModel> listColorModel = dataList
          .map<ColorsModel>((json) => ColorsModel.fromJson(json))
          .toList();
      return listColorModel;
    } else if (response['status'] == "failure") {
      throw NoDataException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addToCart(
    int producID,
    String price,
    int userID,
    String image,
    String nameEn,
    String nameAr,
    int sizeID,
    int colorID,
  ) async {
    final data = {
      "cart_product_id": producID.toString(),
      "product_price": price,
      "cart_user_id": userID.toString(),
      "item_image_name": image,
      "product_name_en": nameEn,
      "product_name_ar": nameAr,
      "size_product_id": sizeID.toString(),
      "color_product_id": colorID.toString(),
    };
    final response = await crud.postData(AppLinks.addToCartLink, data);
    if (response['status'] == "success") {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<CountGroupRatingModel>> countGroupRating(int productID) async {
    final data = {
      "productID": productID.toString(),
    };
    final response = await crud.postData(AppLinks.countGroupRatingLink, data);
    if (response['status'] == "success") {
      List respnseData = response['data'] as List;
      List<CountGroupRatingModel> countGroupRating = respnseData
          .map<CountGroupRatingModel>(
              (json) => CountGroupRatingModel.fromJson(json))
          .toList();
      return countGroupRating;
    } else if (response['status'] == "failure") {
      throw NoDataException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ReviewsModel>> getReviews(int productID, int page) async {
    final data = {
      "productID": productID.toString(),
      "page": page.toString(),
    };
    final response = await crud.postData(AppLinks.reviewsLink, data);
    if (response['status'] == "success") {
      List responseData = response['data'] as List;
      List<ReviewsModel> reviews = responseData
          .map<ReviewsModel>((json) => ReviewsModel.fromJson(json))
          .toList();
      return reviews;
    } else if (response['status'] == "failure") {
      throw NoDataException();
    } else {
      throw ServerException();
    }
  }
}
