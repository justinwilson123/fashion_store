import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/home/domain/entiti/discove_entities.dart';
import 'package:fashion/feature/home/domain/ropositories/home_repository.dart';

class HighLowPriceAllproductUsecase {
  final HomeRepository homeRepository;
  HighLowPriceAllproductUsecase(this.homeRepository);

  Future<Either<Failure, List<ProductEntity>>> call(
    int userID,
    int page,
  ) async {
    return await homeRepository.highLowPriceAllProduct(userID, page);
  }
}
