import 'package:dartz/dartz.dart';
import 'package:fashion/feature/product_details/domain/repositories/product_details_repositories.dart';
import '../../../../core/error/failure.dart';
import '../entity/reviews_entitiy.dart';

class ReviewsUsecase {
  final ProductDetailsRepositories repositores;
  ReviewsUsecase(this.repositores);
  Future<Either<Failure, List<ReviewsEntity>>> call(
      int productID, int page) async {
    return await repositores.getReviews(productID, page);
  }
}
