import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/home/domain/entiti/discove_entities.dart';
import 'package:fashion/feature/home/domain/ropositories/home_repository.dart';

class RangePriceAllproductUsecase {
  final HomeRepository homeRepository;
  RangePriceAllproductUsecase(this.homeRepository);
  Future<Either<Failure, List<ProductEntity>>> call(
    int userID,
    int page,
    int maxPrice,
    int minPrice,
  ) async {
    return await homeRepository.rangePriceAllProduct(
      userID,
      page,
      maxPrice,
      minPrice,
    );
  }
}
