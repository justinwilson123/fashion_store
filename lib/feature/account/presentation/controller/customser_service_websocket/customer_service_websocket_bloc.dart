import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:fashion/core/class/cached_user_info.dart';
import 'package:fashion/core/class/download_file.dart';
import 'package:fashion/core/constant/app_links.dart';
import 'package:fashion/feature/account/data/models/message_model.dart';
import 'package:fashion/feature/account/domain/entities/message_entity.dart';
import 'package:fashion/feature/account/domain/usecase/customer_service_websocket/disconnect_server_use_case.dart';
import 'package:fashion/feature/account/domain/usecase/customer_service_websocket/init_websocket_use_case.dart';
import 'package:fashion/feature/account/domain/usecase/customer_service_websocket/leave_chat_use_case.dart';
import 'package:fashion/feature/account/domain/usecase/customer_service_websocket/send_messages_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatview/chatview.dart';
import 'package:equatable/equatable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../core/services/crud.dart';
import '../../../../../injiction_container.dart' as di;

part 'customer_service_websocket_event.dart';
part 'customer_service_websocket_state.dart';

class CustomerServiceWebsocketBloc
    extends Bloc<CustomerServiceWebsocketEvent, CustomerServiceWebsocketState> {
  final SendMessagesUseCase sendMessagesUseCase;
  final InitWebsocketUseCase initWebsocket;
  final LeaveChatUseCase leaveChatUseCase;
  final DisconnectServerUseCase disconnectServerUseCase;
  StreamSubscription? _streamSubscription;
  final Crud crud;
  final DownloadFile downloadFile;

  // ChatUser currentUser;
  // ChatUser otherUser;
  static late ChatController chatController;
  CustomerServiceWebsocketBloc(
    this.initWebsocket,
    this.sendMessagesUseCase,
    this.leaveChatUseCase,
    this.disconnectServerUseCase,
    this.crud,
    this.downloadFile,
  ) : super(CustomerServiceWebsocketInitial()) {
    on<CustomerServiceWebsocketEvent>((event, emit) async {
      final user = await di.sl<CachedUserInfo>().getUserInfo();

      final dir = await getApplicationCacheDirectory();
      if (event is InitChatMessageEvent) {
        chatController = ChatController(
          initialMessageList: state.messages,
          scrollController: ScrollController(),
          otherUsers: [
            ChatUser(id: "customer_service", name: "customer service"),
          ],
          currentUser: ChatUser(id: user.userId.toString(), name: "me"),
        );
        emit(state.copyWith(isInit: true));
        add(ConnectJoinGetMessageServerEvent());
      } else if (event is ConnectJoinGetMessageServerEvent) {
        emit(state.copyWith(userId: user.userId.toString()));
        final path = dir.path;
        final either = await initWebsocket.call(
          AppLinks.chatWebSocket,
          "${user.userId}",
        );
        either.fold(
          (failure) {
            emit(state.copyWith(errorMessage: "error connect"));
          },
          (handlMessage) {
            _streamSubscription = handlMessage.listen((data) async {
              print(data);
              print(data['action']);
              switch (data['action']) {
                case 'message_history':
                  // معالجة الرسائل التاريخية
                  final List<dynamic> messagesJson = data['messages'];
                  for (int i = 0; messagesJson.length > i; i++) {
                    if (messagesJson[i]['type'] == "image") {
                      bool isDown = await downloadFile.downloadImage(
                        messagesJson[i]['message'],
                      );
                      if (!isDown) {
                        messagesJson.removeAt(i);
                      }
                    } else if (messagesJson[i]['type'] == "audio") {
                      bool isDown = await downloadFile.downloadVoice(
                        messagesJson[i]['message'],
                      );
                      if (!isDown) {
                        messagesJson.removeAt(i);
                      }
                    }
                  }
                  final List<MessageModel> listMessageEntity = [];
                  listMessageEntity.addAll(
                    messagesJson.map((json) {
                      return MessageModel.fromJson(json);
                    }),
                  );

                  final messages = _convertMessages(listMessageEntity, path);
                  add(AddHistoryMessagesEvent(messages));

                  break;

                case 'new_message':
                  final oneMessage = MessageModel.fromJson(data);
                  print(data);
                  if (oneMessage.senderId == "customer_service") {
                    if (oneMessage.type == "image") {
                      bool isDown = await downloadFile.downloadImage(
                        oneMessage.message,
                      );
                      if (isDown) {
                        final messageone = oneMessage.toMessage(path);
                        add(AddNewMessageEvent(messageone));
                      }
                    } else if (oneMessage.type == "audio") {
                      bool isDown = await downloadFile.downloadVoice(
                        oneMessage.message,
                      );
                      if (isDown) {
                        final messageone = oneMessage.toMessage(path);
                        add(AddNewMessageEvent(messageone));
                      }
                    } else {
                      final messageone = oneMessage.toMessage(path);
                      add(AddNewMessageEvent(messageone));
                    }
                  }
              }
            });
          },
        );
      } else if (event is AddHistoryMessagesEvent) {
        chatController.initialMessageList = event.messages;
        emit(
          state.copyWith(
            messages: event.messages,
            chatViewState: event.messages.isEmpty
                ? ChatViewState.noData
                : ChatViewState.hasMessages,
          ),
        );
      } else if (event is AddNewMessageEvent) {
        chatController.addMessage(event.message);
        emit(
          state.copyWith(messages: List.of(state.messages)..add(event.message)),
        );
      } else if (event is LeaveChatDisconnectEvent) {
        leaveChatUseCase.call(user.userId.toString());
        // disconnectServerUseCase.call();
      } else if (event is SendMessageEvent) {
        String fileName = "";
        if (event.messageType.isVoice) {
          fileName = basename(event.text);
          await crud.uploadFileWithStreamUpload(
            AppLinks.uploadVoice,
            event.text,
          );
        }
        if (event.messageType.isImage) {
          fileName = event.text.replaceAll("${dir.path}/", "");
          await crud.uploadFileWithStreamUpload(
            AppLinks.uploadImage,
            event.text,
          );
        }
        Message message = Message(
          messageType: event.messageType,
          message: event.text,
          createdAt: DateTime.now(),
          sentBy: user.userId.toString(),
          status: MessageStatus.read,
        );

        chatController.addMessage(message);
        emit(state.copyWith(chatViewState: ChatViewState.hasMessages));
        MessageEntity messageEntity = MessageEntity(
          senderId: user.userId.toString(),
          receiverId: "customer_service",
          message: event.messageType.isText ? event.text : fileName,
          type: event.type,
          chatId: user.userId.toString(),
          timeStamp: DateTime.now(),
        );
        final either = await sendMessagesUseCase.call(messageEntity);
        either.fold(
          (failure) {
            print("failure");
            emit(state.copyWith(errorMessage: "error send message"));
          },
          (_) {
            print("Success Send Message");
          },
        );
      }
    });
    // _intiChatController();
  }

  List<Message> _convertMessages(List<MessageModel> messages, String path) {
    return messages.map((m) => m.toMessage(path)).toList();
  }

  @override
  Future<void> close() {
    if (_streamSubscription != null) {
      _streamSubscription!.cancel();
    }
    chatController.dispose();
    return super.close();
  }
}

extension MessageConversion on MessageModel {
  Message toMessage(String path) {
    return type == "audio"
        ? Message(
            id: id.toString(),
            message: "$path/$message",
            createdAt: timeStamp,
            sentBy: senderId,
            messageType: MessageType.voice,
            status: MessageStatus.read,
          )
        : type == "image"
        ? Message(
            id: id.toString(),
            message: "$path/$message",
            createdAt: timeStamp,
            sentBy: senderId,
            messageType: MessageType.image,
            status: MessageStatus.read,
          )
        : Message(
            id: id.toString(),
            message: message,
            createdAt: timeStamp,
            sentBy: senderId,
            status: MessageStatus.read,
          );
  }
}
