import 'package:dartz/dartz.dart';
import 'package:fashion/feature/search/domain/repository/search_repository.dart';

import '../../../../core/error/failure.dart';
import '../entity/search_entity.dart';

class RemoveOneCachedResultUseCase {
  final SearchRepository searchRepository;
  RemoveOneCachedResultUseCase(this.searchRepository);
  Future<Either<Failure, Unit>> call(List<SearchEntity> results) async {
    return await searchRepository.removeOneCahedResult(results);
  }
}
