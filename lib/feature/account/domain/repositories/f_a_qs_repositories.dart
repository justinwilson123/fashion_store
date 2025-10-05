import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/account/domain/entities/faqs_entity.dart';

abstract class FAQsRepositories {
  Future<Either<Failure, List<FAQsEntity>>> getGeneralFAQs();
  Future<Either<Failure, List<FAQsEntity>>> getTopicFAQs(String topic);
  Future<Either<Failure, List<FAQsEntity>>> searchFAQs(String search);
}
