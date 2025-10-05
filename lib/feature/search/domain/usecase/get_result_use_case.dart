import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/search/domain/entity/search_entity.dart';
import 'package:fashion/feature/search/domain/repository/search_repository.dart';

class GetResultUseCase {
  final SearchRepository searchRepository;
  GetResultUseCase(this.searchRepository);
  Future<Either<Failure, List<SearchEntity>>> call(String name) async {
    return await searchRepository.getResult(name);
  }
}
