import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/home/domain/entiti/discove_entities.dart';
import 'package:fashion/feature/home/domain/ropositories/home_repository.dart';

class GetAllProductUsecase {
  final HomeRepository homeRepository;
  GetAllProductUsecase(this.homeRepository);
  Future<Either<Failure, List<ProductEntity>>> call(
    int userID,
    int page,
  ) async {
    return await homeRepository.getAllProduct(userID, page);
  }
}
