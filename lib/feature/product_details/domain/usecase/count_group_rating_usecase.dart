import 'package:dartz/dartz.dart';
import 'package:fashion/feature/product_details/domain/repositories/product_details_repositories.dart';
import '../../../../core/error/failure.dart';
import '../entity/reviews_entitiy.dart';

class CountGroupRatingUsecase {
  final ProductDetailsRepositories repositores;
  CountGroupRatingUsecase(this.repositores);
  Future<Either<Failure, List<CountGroupByRatingEntity>>> call(
      int productID) async {
    return await repositores.getCountGroupRating(productID);
  }
}
