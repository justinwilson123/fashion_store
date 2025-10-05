import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/home/domain/ropositories/home_repository.dart';

class GetMaxPriceUsecase {
  final HomeRepository homeRepository;
  GetMaxPriceUsecase(this.homeRepository);
  Future<Either<Failure, String>> call() async {
    return await homeRepository.getMaxPriceAllProduct();
  }
}
