import 'package:fashion/feature/saved/domine/entity/saved_product_entity.dart';

class SavedProductModel extends SavedProductEntity {
  const SavedProductModel({
    required super.productId,
    required super.productCategoryId,
    required super.nameEn,
    required super.nameAr,
    required super.descriptionEn,
    required super.descriptionAr,
    required super.productPrice,
    required super.productImage,
    required super.productDiscount,
    required super.productActive,
    required super.countRating,
    required super.avgRating,
    required super.review,
  });

  factory SavedProductModel.fromJson(Map<String, dynamic> json) {
    return SavedProductModel(
      productId: json['product_id'],
      productCategoryId: json['product_category_id'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
      descriptionEn: json['description_en'],
      descriptionAr: json['description_ar'],
      productPrice: json['product_price'],
      productImage: json['product_image'],
      productDiscount: json['product_discount'],
      productActive: json['product_active'],
      countRating: json['count_rating'],
      avgRating: json['Avg_rating'],
      review: json['Review'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "product_id": productId,
      "product_category_id": productCategoryId,
      "name_en": nameEn,
      "name_ar": nameAr,
      "description_en": descriptionEn,
      "description_ar": descriptionAr,
      "product_price": productPrice,
      "product_image": productImage,
      "product_discount": productDiscount,
      "product_active": productActive,
      "count_rating": countRating,
      "Avg_rating": avgRating,
      "Review": review
    };
  }
}
