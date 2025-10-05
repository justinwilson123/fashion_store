import 'package:dartz/dartz.dart';
import 'package:fashion/core/class/download_file.dart';
import 'package:fashion/core/services/crud.dart';
import 'package:fashion/core/services/firebase_database_service.dart';
import 'package:fashion/core/services/websocket_service.dart';
import 'package:fashion/feature/account/data/models/last_message_model.dart';
import 'package:fashion/feature/account/data/models/message_model.dart';
import '../../../../core/error/exception.dart';

abstract class CustomerServiceRemoteDataSources {
  Stream<List<MessageModel>> getMessage(String userID);
  Future<Unit> sendMessage(
    String userID,
    MessageModel message,
    String userImage,
    String userFullName,
  );
  // Future<Stream<double>> sendVoice(String path);
}

class CustomerServiceRemoteFirestoreDataSource
    implements CustomerServiceRemoteDataSources {
  final FirebaseDatabaseService firebaseDatabaseService;
  final Crud crud;
  CustomerServiceRemoteFirestoreDataSource(
    this.firebaseDatabaseService,
    this.crud,
  );
  @override
  Stream<List<MessageModel>> getMessage(String userID) {
    try {
      return firebaseDatabaseService.getMessage(userID);
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<Unit> sendMessage(
    String userID,
    MessageModel message,
    String userImage,
    String userFullName,
  ) async {
    try {
      final lastMessage = LastMessageModel(
        imageName: userImage,
        nameUser: userFullName,
        lastMessage: message.message,
        senderID: message.senderId,
        time: message.timeStamp,
      );

      if (!(await firebaseDatabaseService.checkChatExists(userID))) {
        await firebaseDatabaseService.creatNewChat(
          lastMessage: lastMessage,
          userID: userID,
        );
      } else {
        await firebaseDatabaseService.updateLateMessage(lastMessage, userID);
      }

      await firebaseDatabaseService.sendMessage(message, userID);
      return unit;
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }
}

//============================= Websocket ==========================

class CustomerServiceRemoteWebsocketDataSource {
  final WebSocketService _webSocketService;
  final DownloadFile downloadFile;
  CustomerServiceRemoteWebsocketDataSource(
    this._webSocketService,
    this.downloadFile,
  );

  Stream<Map<String, dynamic>> initWebSocketData(String url, String chatId) {
    _webSocketService.connect(url);
    _webSocketService.joinChat(chatId);
    return _webSocketService.messageStream;
  }

  Future<Unit> disconnect() async {
    _webSocketService.disconnect();
    return Future.value(unit);
  }

  Future<Unit> leaveChat(String chatId) async {
    _webSocketService.leaveChat(chatId);
    return Future.value(unit);
  }

  Future<Unit> sendMessage(MessageModel message) async {
    // final data = message.toJson();
    _webSocketService.sendTextMessage(
      message.chatId,
      message.message,
      message.senderId,
      message.type,
      message.receiverId,
    );
    return Future.value(unit);
  }
}
