import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/account/domain/entities/faqs_entity.dart';
import 'package:fashion/feature/account/domain/repositories/f_a_qs_repositories.dart';

class GetGeneralFAQsUsecase {
  final FAQsRepositories faQsRepositories;
  GetGeneralFAQsUsecase(this.faQsRepositories);
  Future<Either<Failure, List<FAQsEntity>>> call() async {
    return await faQsRepositories.getGeneralFAQs();
  }
}
