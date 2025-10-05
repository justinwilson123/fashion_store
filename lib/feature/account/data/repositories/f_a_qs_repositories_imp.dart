import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/core/services/network_info.dart';
import 'package:fashion/feature/account/data/data/f_a_qs_remote_data_sources.dart';
import 'package:fashion/feature/account/data/models/f_a_qs_model.dart';
import 'package:fashion/feature/account/domain/entities/faqs_entity.dart';
import 'package:fashion/feature/account/domain/repositories/f_a_qs_repositories.dart';

import '../../../../core/error/exception.dart';

typedef GetFAQs = Future<List<FAQsModel>> Function();

class FAQsRepositoriesImp implements FAQsRepositories {
  final NetworkInfo networkInfo;
  final FAQsRemoteDataSources faQs;
  FAQsRepositoriesImp(this.networkInfo, this.faQs);
  @override
  Future<Either<Failure, List<FAQsEntity>>> getGeneralFAQs() async {
    return await _getFAQs(() {
      return faQs.getGeneralFAQs();
    });
  }

  @override
  Future<Either<Failure, List<FAQsEntity>>> getTopicFAQs(String topic) async {
    return await _getFAQs(() {
      return faQs.getTopicFAQs(topic);
    });
  }

  @override
  Future<Either<Failure, List<FAQsEntity>>> searchFAQs(String search) async {
    return await _getFAQs(() {
      return faQs.getSearchFAQs(search);
    });
  }

  Future<Either<Failure, List<FAQsEntity>>> _getFAQs(GetFAQs getFAQs) async {
    if (await networkInfo.isConnected) {
      try {
        final faqs = await getFAQs();
        return Right(faqs);
      } on ServerException {
        return Left(ServerFailure());
      } on NoDataException {
        return Left(NoDataFailure());
      } catch (e) {
        print(e);
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
