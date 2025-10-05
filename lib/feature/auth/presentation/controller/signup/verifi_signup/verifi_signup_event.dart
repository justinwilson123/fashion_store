import 'package:equatable/equatable.dart';

sealed class VerifiSignupEvent extends Equatable {
  const VerifiSignupEvent();

  @override
  List<Object> get props => [];
}

class ResendVerifiCodeEvent extends VerifiSignupEvent {
  final String email;
  const ResendVerifiCodeEvent(this.email);
  @override
  List<Object> get props => [email];
}

class SendVerifiCodeForVerifiEmailEvent extends VerifiSignupEvent {
  final String email;
  final String verifiCode;
  const SendVerifiCodeForVerifiEmailEvent(this.email, this.verifiCode);
  @override
  List<Object> get props => [email, verifiCode];
}

class CompleatFillFiledVerifiCodeEvent extends VerifiSignupEvent {
  final bool validFiled;
  const CompleatFillFiledVerifiCodeEvent(this.validFiled);
  @override
  List<Object> get props => [validFiled];
}
