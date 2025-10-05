import 'package:dartz/dartz.dart';
import 'package:fashion/feature/search/domain/entity/search_entity.dart';
import 'package:fashion/feature/search/domain/repository/search_repository.dart';

import '../../../../core/error/failure.dart';

class CachedResultUseCase {
  final SearchRepository searchRepository;
  CachedResultUseCase(this.searchRepository);
  Future<Either<Failure, Unit>> call(List<SearchEntity> results) async {
    return await searchRepository.cachedResult(results);
  }
}
