import 'package:dartz/dartz.dart';
import 'package:fashion/feature/home/domain/ropositories/home_repository.dart';

import '../../../../core/error/failure.dart';

class GetMaxPriceProductUsecase {
  final HomeRepository homeRepository;
  GetMaxPriceProductUsecase(this.homeRepository);
  Future<Either<Failure, String>> call(int categoryID) async {
    return await homeRepository.getMaxPriceProduct(categoryID);
  }
}
