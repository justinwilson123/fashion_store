import 'package:dartz/dartz.dart';
import 'package:fashion/feature/home/domain/entiti/discove_entities.dart';
import 'package:fashion/feature/home/domain/ropositories/home_repository.dart';

import '../../../../core/error/failure.dart';

class HighLowPriceProductUsecase {
  final HomeRepository homeRepository;
  HighLowPriceProductUsecase(this.homeRepository);
  Future<Either<Failure, List<ProductEntity>>> call(
    int catogryID,
    int userID,
    int page,
  ) async {
    return await homeRepository.highLowPriceProduct(catogryID, userID, page);
  }
}
