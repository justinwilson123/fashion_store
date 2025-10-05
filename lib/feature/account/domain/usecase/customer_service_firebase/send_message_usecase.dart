import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/account/domain/entities/message_entity.dart';
import 'package:fashion/feature/account/domain/repositories/customer_service_repository.dart';

class SendMessageUseCase {
  final CustomerServiceRepositoryFirebase customerService;
  SendMessageUseCase(this.customerService);
  Future<Either<Failure, Unit>> call(
    String userID,
    MessageEntity message,
    String userImage,
    String userFullName,
  ) async {
    return await customerService.sendMessage(
      userID,
      message,
      userImage,
      userFullName,
    );
  }
}
