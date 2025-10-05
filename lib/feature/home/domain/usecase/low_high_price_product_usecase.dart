import 'package:dartz/dartz.dart';
import 'package:fashion/feature/home/domain/entiti/discove_entities.dart';
import 'package:fashion/feature/home/domain/ropositories/home_repository.dart';

import '../../../../core/error/failure.dart';

class LowHighPriceProductUsecase {
  final HomeRepository homeRepository;
  LowHighPriceProductUsecase(this.homeRepository);
  Future<Either<Failure, List<ProductEntity>>> call(
    int catogryID,
    int userID,
    int page,
  ) async {
    return await homeRepository.lowHighPriceProduct(catogryID, userID, page);
  }
}
