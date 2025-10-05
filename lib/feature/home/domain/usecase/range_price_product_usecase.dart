import 'package:dartz/dartz.dart';
import 'package:fashion/feature/home/domain/entiti/discove_entities.dart';
import 'package:fashion/feature/home/domain/ropositories/home_repository.dart';

import '../../../../core/error/failure.dart';

class RangePriceProductUsecase {
  final HomeRepository homeRepository;
  RangePriceProductUsecase(this.homeRepository);
  Future<Either<Failure, List<ProductEntity>>> call(
    int catogryID,
    int userID,
    int page,
    int maxPrice,
    int minPrice,
  ) async {
    return await homeRepository.rangPriceProduct(
      catogryID,
      userID,
      page,
      maxPrice,
      minPrice,
    );
  }
}
