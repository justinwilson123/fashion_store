import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/home/domain/entiti/discove_entities.dart';
import 'package:fashion/feature/home/domain/ropositories/home_repository.dart';

class LowHighPriceAllproductUsecase {
  final HomeRepository homeRepository;
  LowHighPriceAllproductUsecase(this.homeRepository);
  Future<Either<Failure, List<ProductEntity>>> call(
    int userID,
    int page,
  ) async {
    return await homeRepository.lowHighPriceAllProduct(userID, page);
  }
}
