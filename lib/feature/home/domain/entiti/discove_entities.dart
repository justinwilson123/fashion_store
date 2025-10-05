import 'package:equatable/equatable.dart';

class CategoryEntiti extends Equatable {
  final int categoryId;
  final String categoryNameEn;
  final String categoryNameAr;

  const CategoryEntiti({
    required this.categoryId,
    required this.categoryNameAr,
    required this.categoryNameEn,
  });

  @override
  List<Object?> get props => [categoryId, categoryNameAr, categoryNameEn];
}

class ProductEntity extends Equatable {
  final int productId;
  final int productCategoryId;
  final String nameEn;
  final String nameAr;
  final String descriptionEn;
  final String descriptionAr;
  final String productPrice;
  final String productImage;
  final int productDiscount;
  final int productActive;
  final int countRating;
  final String avgRating;
  final int review;
  final int favorite;

  const ProductEntity({
    required this.productId,
    required this.productCategoryId,
    required this.nameEn,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.productPrice,
    required this.productImage,
    required this.productDiscount,
    required this.productActive,
    required this.countRating,
    required this.avgRating,
    required this.review,
    required this.favorite,
  });

  @override
  List<Object?> get props => [
    productId,
    productCategoryId,
    nameEn,
    nameAr,
    descriptionEn,
    descriptionAr,
    productPrice,
    productImage,
    productDiscount,
    productActive,
    countRating,
    avgRating,
    review,
    favorite,
  ];
}
