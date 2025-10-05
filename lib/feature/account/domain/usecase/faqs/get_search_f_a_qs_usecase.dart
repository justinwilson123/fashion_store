import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/account/domain/entities/faqs_entity.dart';
import 'package:fashion/feature/account/domain/repositories/f_a_qs_repositories.dart';

class GetSearchFAQsUsecase {
  final FAQsRepositories faQsRepositories;
  GetSearchFAQsUsecase(this.faQsRepositories);

  Future<Either<Failure, List<FAQsEntity>>> call(String search) async {
    return await faQsRepositories.searchFAQs(search);
  }
}
