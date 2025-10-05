part of 'customer_service_bloc.dart';

sealed class CustomerServiceEvent extends Equatable {
  const CustomerServiceEvent();

  @override
  List<Object> get props => [];
}

class StartRecordVoiceEvent extends CustomerServiceEvent {
  const StartRecordVoiceEvent();
  @override
  List<Object> get props => [];
}

class StopRecordVoiceEvent extends CustomerServiceEvent {
  const StopRecordVoiceEvent();
  @override
  List<Object> get props => [];
}

class SendVoiceEvent extends CustomerServiceEvent {
  // final ChatMessage chatMessage;

  const SendVoiceEvent();

  @override
  List<Object> get props => [];
}

class IsRecordEvent extends CustomerServiceEvent {
  final bool isRecord;
  const IsRecordEvent(this.isRecord);
  @override
  List<Object> get props => [isRecord];
}

class StreamMessageEvent extends CustomerServiceEvent {
  const StreamMessageEvent();
  @override
  List<Object> get props => [];
}

class AddMessageEvent extends CustomerServiceEvent {
  final List<Message> messages;
  const AddMessageEvent(this.messages);
  @override
  List<Object> get props => [messages];

}

class GetUserIDEvent extends CustomerServiceEvent {
  const GetUserIDEvent();
  @override
  List<Object> get props => [];
}

class SendMessageEvent extends CustomerServiceEvent {
  // final ChatMessage chatMessage;
  const SendMessageEvent();
  @override
  List<Object> get props => [];
}
