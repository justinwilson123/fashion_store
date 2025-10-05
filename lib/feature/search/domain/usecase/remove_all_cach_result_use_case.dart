import 'package:dartz/dartz.dart';
import 'package:fashion/feature/search/domain/repository/search_repository.dart';

import '../../../../core/error/failure.dart';

class RemoveAllCachResultUseCase {
  final SearchRepository searchRepository;
  RemoveAllCachResultUseCase(this.searchRepository);
  Future<Either<Failure, Unit>> call() async {
    return await searchRepository.removeAllCachedResult();
  }
}
