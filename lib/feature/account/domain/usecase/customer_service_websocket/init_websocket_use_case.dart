import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';

import '../../repositories/customer_service_repository.dart';

class InitWebsocketUseCase {
  final CustomerServiceRepositoryWebsoket repositoryWebsoket;
  InitWebsocketUseCase(this.repositoryWebsoket);
  Future<Either<Failure, Stream<Map<String, dynamic>>>> call(
    String url,
    String chatId,
  ) async {
    return await repositoryWebsoket.initWebsocket(url, chatId);
  }
}
