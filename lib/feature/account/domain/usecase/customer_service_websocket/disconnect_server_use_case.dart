import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';

import '../../repositories/customer_service_repository.dart';

class DisconnectServerUseCase {
  final CustomerServiceRepositoryWebsoket repositoryWebsoket;
  DisconnectServerUseCase(this.repositoryWebsoket);
  Future<Either<Failure, Unit>> call() async {
    return await repositoryWebsoket.disconnect();
  }
}
