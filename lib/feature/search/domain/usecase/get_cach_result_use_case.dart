import 'package:dartz/dartz.dart';
import 'package:fashion/feature/search/domain/repository/search_repository.dart';

import '../../../../core/error/failure.dart';
import '../entity/search_entity.dart';

class GetCachResultUseCase {
  final SearchRepository searchRepository;
  GetCachResultUseCase(this.searchRepository);
  Future<Either<Failure, List<SearchEntity>>> call() async {
    return await searchRepository.getCachResult();
  }
}
