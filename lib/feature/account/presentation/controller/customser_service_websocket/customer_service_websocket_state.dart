part of 'customer_service_websocket_bloc.dart';

class CustomerServiceWebsocketState extends Equatable {
  final List<Message> messages;
  final String userId;
  final bool isInit;
  final ChatViewState chatViewState;
  final String errorMessage;
  const CustomerServiceWebsocketState({
    this.errorMessage = "",
    this.chatViewState = ChatViewState.loading,
    this.messages = const [],
    this.userId = "",
    this.isInit = false,
  });

  CustomerServiceWebsocketState copyWith({
    List<Message>? messages,
    String? errorMessage,
    ChatViewState? chatViewState,
    String? userId,
    bool? isInit,
  }) {
    return CustomerServiceWebsocketState(
      messages: messages ?? this.messages,
      errorMessage: errorMessage ?? this.errorMessage,
      chatViewState: chatViewState ?? this.chatViewState,
      userId: userId ?? this.userId,
      isInit: isInit ?? this.isInit,
    );
  }

  @override
  List<Object> get props => [
    messages,
    errorMessage,
    chatViewState,
    userId,
    isInit,
  ];
}

final class CustomerServiceWebsocketInitial
    extends CustomerServiceWebsocketState {}

class InitChatControllserState extends CustomerServiceWebsocketState {}
