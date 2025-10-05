import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/account/domain/entities/message_entity.dart';
import 'package:fashion/feature/account/domain/repositories/customer_service_repository.dart';

class GetMessageUseCase {
  final CustomerServiceRepositoryFirebase customerService;
  GetMessageUseCase(this.customerService);
  Future<Either<Failure, Stream<List<MessageEntity>>>> call(
    String userID,
  ) async {
    return customerService.getMessage(userID);
  }
}
