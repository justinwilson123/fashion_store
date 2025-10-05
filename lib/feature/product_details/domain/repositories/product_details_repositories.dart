import 'package:dartz/dartz.dart';
import 'package:fashion/feature/product_details/domain/entity/details_entities.dart';

import '../../../../core/error/failure.dart';
import '../entity/reviews_entitiy.dart';

abstract class ProductDetailsRepositories {
  Future<Either<Failure, List<SizedEntity>>> getSizes(int productID);
  Future<Either<Failure, List<ColorsEntity>>> getColors(
      int productID, int sizeID);
  Future<Either<Failure, Unit>> addToCart(
    int producID,
    String price,
    int userID,
    String image,
    String nameEn,
    String nameAr,
    int sizeID,
    int colorID,
  );

  Future<Either<Failure, List<CountGroupByRatingEntity>>> getCountGroupRating(
      int productID);
  Future<Either<Failure, List<ReviewsEntity>>> getReviews(
      int productID, int page);
}
