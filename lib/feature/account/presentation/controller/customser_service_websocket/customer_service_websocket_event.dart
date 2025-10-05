part of 'customer_service_websocket_bloc.dart';

sealed class CustomerServiceWebsocketEvent extends Equatable {
  const CustomerServiceWebsocketEvent();

  @override
  List<Object> get props => [];
}

class InitChatMessageEvent extends CustomerServiceWebsocketEvent {
  const InitChatMessageEvent();
  @override
  List<Object> get props => [];
}

class ConnectJoinGetMessageServerEvent extends CustomerServiceWebsocketEvent {
  const ConnectJoinGetMessageServerEvent();
  @override
  List<Object> get props => [];
}

class AddHistoryMessagesEvent extends CustomerServiceWebsocketEvent {
  final List<Message> messages;
  const AddHistoryMessagesEvent(this.messages);
  @override
  List<Object> get props => [messages];
}

class AddNewMessageEvent extends CustomerServiceWebsocketEvent {
  final Message message;
  const AddNewMessageEvent(this.message);
  @override
  List<Object> get props => [message];
}

class SendMessageEvent extends CustomerServiceWebsocketEvent {
  final String text;
  final String type;
  final MessageType messageType;
  const SendMessageEvent(this.text, this.type, this.messageType);
  @override
  List<Object> get props => [text, type];
}

class LeaveChatDisconnectEvent extends CustomerServiceWebsocketEvent {
  const LeaveChatDisconnectEvent();
  @override
  List<Object> get props => [];
}
