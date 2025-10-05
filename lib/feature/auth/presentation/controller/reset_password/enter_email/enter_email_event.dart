part of 'enter_email_bloc.dart';

sealed class EnterEmailEvent extends Equatable {
  const EnterEmailEvent();

  @override
  List<Object> get props => [];
}

class ValidEmailFaildEvent extends EnterEmailEvent {
  final bool validEmail;
  const ValidEmailFaildEvent(this.validEmail);
  @override
  List<Object> get props => [validEmail];
}

class SendEamilForSendVerifiCode extends EnterEmailEvent {
  final String email;
  const SendEamilForSendVerifiCode(this.email);
  @override
  List<Object> get props => [email];
}
