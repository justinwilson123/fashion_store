import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/account/domain/entities/message_entity.dart';

abstract class CustomerServiceRepositoryFirebase {
  Future<Either<Failure, Stream<List<MessageEntity>>>> getMessage(
    String userID,
  );

  Future<Either<Failure, Unit>> sendMessage(
    String userID,
    MessageEntity message,
    String userImage,
    String userFullName,
  );
  Future<Either<Failure, Stream<double>>> sendVoice(String filePath);
}

abstract class CustomerServiceRepositoryWebsoket {
  Future<Either<Failure, Stream<Map<String, dynamic>>>> initWebsocket(
    String url,
    String chatId,
  );
  Future<Either<Failure, Unit>> disconnect();
  Future<Either<Failure, Unit>> leaveChat(String chatId);
  Future<Either<Failure, Unit>> sendMessage(MessageEntity message);
}
