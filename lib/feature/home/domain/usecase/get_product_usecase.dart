import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/home/domain/entiti/discove_entities.dart';
import 'package:fashion/feature/home/domain/ropositories/home_repository.dart';

class GetProductUsecase {
  final HomeRepository homeRepository;
  GetProductUsecase(this.homeRepository);

  Future<Either<Failure, List<ProductEntity>>> call(
    int userID,
    int categoryID,
    int page,
  ) async {
    return await homeRepository.getProduct(userID, categoryID, page);
  }
}
