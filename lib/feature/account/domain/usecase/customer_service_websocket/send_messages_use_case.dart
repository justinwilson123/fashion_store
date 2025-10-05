import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/account/domain/entities/message_entity.dart';
import 'package:fashion/feature/account/domain/repositories/customer_service_repository.dart';

class SendMessagesUseCase {
  final CustomerServiceRepositoryWebsoket repositoryWebsoket;
  SendMessagesUseCase(this.repositoryWebsoket);
  Future<Either<Failure, Unit>> call(MessageEntity message) async {
    return await repositoryWebsoket.sendMessage(message);
  }
}
