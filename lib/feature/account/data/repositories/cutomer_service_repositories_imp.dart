import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/exception.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/core/services/network_info.dart';
import 'package:fashion/feature/account/data/models/message_model.dart';
import 'package:fashion/feature/account/domain/entities/message_entity.dart';
import 'package:fashion/feature/account/domain/repositories/customer_service_repository.dart';

import '../data/customer_service_remote_data_sources.dart';

class CustomerServiceRepositoriesImp
    implements CustomerServiceRepositoryFirebase {
  final NetworkInfo networkInfo;
  final CustomerServiceRemoteDataSources remoteData;
  CustomerServiceRepositoriesImp(this.networkInfo, this.remoteData);
  @override
  Future<Either<Failure, Stream<List<MessageEntity>>>> getMessage(
    String userID,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final message = remoteData.getMessage(userID);
        return Right(message);
      } catch (e) {
        print(e);
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> sendMessage(
    String userID,
    MessageEntity messages,
    String userImage,
    String userFullName,
  ) async {
    final MessageModel messageModel = MessageModel(
      senderId: messages.senderId,
      receiverId: messages.receiverId,
      message: messages.message,
      chatId: messages.chatId,
      type: messages.type,
      timeStamp: messages.timeStamp,
    );

    if (await networkInfo.isConnected) {
      try {
        await remoteData.sendMessage(
          userID,
          messageModel,
          userImage,
          userFullName,
        );
        return const Right(unit);
      } catch (e) {
        print(e);
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Stream<double>>> sendVoice(String filePath) async {
    if (await networkInfo.isConnected) {
      try {
        // final stream = await remoteData.sendVoice(filePath);
        throw Right(ServerFailure());
        // return Right(stream);
      } on NoDataException {
        return Left(NoDataFailure());
      } catch (e) {
        print("++++++++++++++++++++++++++++++++++++$e");
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
//===========================================================

//                      WebSocket
//=========================================================
class CustomerServiceRepositoriesWebSocketImp
    implements CustomerServiceRepositoryWebsoket {
  final NetworkInfo networkInfo;
  final CustomerServiceRemoteWebsocketDataSource websocketDataSource;
  CustomerServiceRepositoriesWebSocketImp(
    this.networkInfo,
    this.websocketDataSource,
  );

  @override
  Future<Either<Failure, Unit>> disconnect() async {
    if (await networkInfo.isConnected) {
      try {
        await websocketDataSource.disconnect();
        return const Right(unit);
      } catch (e) {
        print(e);
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> leaveChat(String chatId) async {
    if (await networkInfo.isConnected) {
      try {
        await websocketDataSource.leaveChat(chatId);
        return const Right(unit);
      } catch (e) {
        print(e);
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Stream<Map<String, dynamic>>>> initWebsocket(
    String url,
    String chatId,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        Stream<Map<String, dynamic>> streamMessage = websocketDataSource
            .initWebSocketData(url, chatId);
        return Right(streamMessage);
      } catch (e) {
        print(e);
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> sendMessage(MessageEntity message) async {
    final MessageModel messageModel = MessageModel(
      senderId: message.senderId,
      receiverId: message.receiverId,
      message: message.message,
      type: message.type,
      chatId: message.chatId,
      timeStamp: message.timeStamp,
    );
    if (await networkInfo.isConnected) {
      try {
        await websocketDataSource.sendMessage(messageModel);
        return const Right(unit);
      } catch (e) {
        print(e);
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
