import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/account/domain/repositories/customer_service_repository.dart';

class LeaveChatUseCase {
  final CustomerServiceRepositoryWebsoket repositoryWebsoket;
  LeaveChatUseCase(this.repositoryWebsoket);
  Future<Either<Failure, Unit>> call(String chatId) async {
    return await repositoryWebsoket.leaveChat(chatId);
  }
}
