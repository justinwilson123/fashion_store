import 'dart:async';
import 'package:chatview/chatview.dart';
import 'package:fashion/core/class/cached_user_info.dart';
import 'package:fashion/core/constant/app_links.dart';
import 'package:fashion/core/services/crud.dart';
import 'package:fashion/feature/account/domain/entities/message_entity.dart';
import 'package:fashion/feature/account/domain/usecase/customer_service_firebase/get_message_usecase.dart';
import 'package:fashion/feature/account/domain/usecase/customer_service_firebase/send_message_usecase.dart';
import 'package:fashion/feature/account/domain/usecase/customer_service_firebase/send_voice_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:flutter_chat_core/flutter_chat_core.dart';
// import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:path/path.dart';
import '../../../../../core/class/record_voice.dart';
import '../../../../../core/constant/strings/failure_message.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../injiction_container.dart' as di;

part 'customer_service_event.dart';
part 'customer_service_state.dart';

class CustomerServiceBloc
    extends Bloc<CustomerServiceEvent, CustomerServiceState> {
  final GetMessageUseCase getMessage;
  final SendVoiceUseCase sendVoice;
  final SendMessageUseCase sendMessage;
  final Crud crud;
  // InMemoryChatController chatController = InMemoryChatController();
  StreamSubscription<List<MessageEntity>>? streamSubscription;
  StreamSubscription<double>? streamSubscriptionUpload;
  CustomerServiceBloc(
    this.crud,
    this.getMessage,
    this.sendVoice,
    this.sendMessage,
  ) : super(CustomerServiceInitial()) {
    on<StartRecordVoiceEvent>((event, emit) async {
      final user = await di.sl<CachedUserInfo>().getUserInfo();
      await di.sl<RecordVoice>().recoding(user.userId!);
    });
    on<StopRecordVoiceEvent>((event, emit) async {
      // final user = await di.sl<CachedUserInfo>().getUserInfo();
      final filePath = await di.sl<RecordVoice>().stopRecord();
      // final voicName = (basename(filePath!));
      final either = await sendVoice.call(filePath!);
      either.fold((failue) {}, (upload) {
        streamSubscriptionUpload = upload.listen((loading) {
          if (loading == 1.0) {
            // final chatMessage = ChatMessage(
            //   user: ChatUser(id: "${user.userId}"),
            //   createdAt: DateTime.now(),
            //   text: voicName,
            // );
            add(SendVoiceEvent());
          }
        });
      });
    });
    on<SendVoiceEvent>((event, emit) async {});
    on<CustomerServiceEvent>((event, emit) async {
      final user = await di.sl<CachedUserInfo>().getUserInfo();
      if (event is GetUserIDEvent) {
        emit(state.copyWith(userID: user.userId));
      } else if (event is IsRecordEvent) {
        emit(state.copyWith(isRecord: event.isRecord));
      } else if (event is StreamMessageEvent) {
        final either = await getMessage.call(user.userId!.toString());
        either.fold(
          (failure) {
            emit(
              state.copyWith(
                errorMessage: _mapFailureToMessage(failure),
                isLoading: false,
              ),
            );
          },
          (querySnapShot) {
            streamSubscription?.cancel();
            streamSubscription = querySnapShot.listen((messages) {
              final chatMessage = _convertMessages(user.userId!, messages);
              add(AddMessageEvent(chatMessage));
            });
          },
        );
      } else if (event is AddMessageEvent) {
        // chatController.insertAllMessages(event.messages);
        emit(state.copyWith(chatMessage: event.messages, isLoading: false));
      } else if (event is SendMessageEvent) {
        final MessageEntity message = MessageEntity(
          chatId: '1',
          senderId: user.userId.toString(),
          receiverId: "service",
          message: "event.chatMessage.text",
          timeStamp: DateTime.now(),
          type: "text",
        );
        await sendMessage.call(
          user.userId!.toString(),
          message,
          user.userImage!,
          user.userFullName,
        );
      } else if (event is SendVoiceEvent) {
        final MessageEntity message = MessageEntity(
          chatId: "1",
          senderId: user.userId.toString(),
          receiverId: "service",
          message: "event.chatMessage.text",
          timeStamp: DateTime.now(),
          type: "voice",
        );
        await sendMessage.call(
          user.userId!.toString(),
          message,
          user.userImage!,
          user.userFullName,
        );
      }
    });
  }

  List<Message> _convertMessages(int myId, List<MessageEntity> messages) {
    return messages.map((m) => m.toChatMessage(myId)).toList();
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure == ServerFailure()) {
      return SERVER_FAILURE_MESSAGE;
    } else if (failure == OffLineFailure()) {
      return OFFLINE_FAILURE_MESSAGE;
    } else if (failure is NoDataFailure) {
      return "";
    } else {
      return "UnExpected Error , please try again later";
    }
  }

  @override
  Future<void> close() {
    if (streamSubscription != null) {
      streamSubscription!.cancel();
    }
    if (streamSubscriptionUpload != null) {
      streamSubscriptionUpload!.cancel;
    }
    return super.close();
  }
}

extension MessageConversion on MessageEntity {
  Message toChatMessage(int myId) {
    return type == "text"
        ? Message(message: message, createdAt: timeStamp, sentBy: senderId)
        : Message(message: message, createdAt: timeStamp, sentBy: senderId);
  }
}

// _changMessages(int myID, List<MessageEntity> message) {
  //   return message.map((m) {
  //     if (m.type == "image") {
  //       return ChatMessage(
  //         user: m.senderId == myID.toString()
  //             ? ChatUser(id: "$myID")
  //             : ChatUser(id: "service"),
  //         createdAt: m.time,
  //         status: MessageStatus.read,
  //         medias: [
  //           ChatMedia(
  //             url: "${AppLinks.imageUrl}${m.message}",
  //             fileName: m.message,
  //             type: MediaType.image,
  //           ),
  //         ],
  //       );
  //     } else {
  //       return ChatMessage(
  //         status: MessageStatus.read,
  //         user: m.senderId == myID.toString()
  //             ? ChatUser(id: "$myID")
  //             : ChatUser(id: "service"),
  //         text: m.message,
  //         createdAt: m.time,
  //       );
  //     }
  //   }).toList();
  // }