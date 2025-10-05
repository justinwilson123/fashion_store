part of 'verifi_email_bloc.dart';

sealed class VerifiEmailEvent extends Equatable {
  const VerifiEmailEvent();

  @override
  List<Object> get props => [];
}

class InitVerifiEmailEvent extends VerifiEmailEvent {
  @override
  List<Object> get props => [];
}

class CompleatFillFiledCodeEvent extends VerifiEmailEvent {
  final bool isValid;
  const CompleatFillFiledCodeEvent(this.isValid);
  @override
  List<Object> get props => [isValid];
}

class SendVerifiCodeEvent extends VerifiEmailEvent {
  final String email;
  final String verifiCode;
  const SendVerifiCodeEvent(this.email, this.verifiCode);
  @override
  List<Object> get props => [email, verifiCode];
}

class ResendVerifiCodeEmail extends VerifiEmailEvent {
  final String email;
  const ResendVerifiCodeEmail(this.email);
  @override
  List<Object> get props => [email];
}
