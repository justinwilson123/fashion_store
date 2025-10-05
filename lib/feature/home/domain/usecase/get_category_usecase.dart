import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/home/domain/entiti/discove_entities.dart';
import 'package:fashion/feature/home/domain/ropositories/home_repository.dart';

class GetCategoryUsecase {
  final HomeRepository homeRepository;
  GetCategoryUsecase(this.homeRepository);

  Future<Either<Failure, List<CategoryEntiti>>> call() async {
    return await homeRepository.getCategory();
  }
}
