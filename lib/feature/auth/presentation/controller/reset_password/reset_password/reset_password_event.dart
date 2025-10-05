part of 'reset_password_bloc.dart';

sealed class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class ValidPasswordFiledEvent extends ResetPasswordEvent {
  final bool isValidPass;
  const ValidPasswordFiledEvent(this.isValidPass);
  @override
  List<Object> get props => [isValidPass];
}

class ValidRePasswordFiledEvent extends ResetPasswordEvent {
  final bool isValisRepass;
  const ValidRePasswordFiledEvent(this.isValisRepass);
  @override
  List<Object> get props => [isValisRepass];
}

class ShowePasswordEvent extends ResetPasswordEvent {
  final bool showePass;
  const ShowePasswordEvent(this.showePass);
  @override
  List<Object> get props => [showePass];
}

class ShoweRePasswordEvent extends ResetPasswordEvent {
  final bool showeRepass;
  const ShoweRePasswordEvent(this.showeRepass);
  @override
  List<Object> get props => [showeRepass];
}

class GoToResetPasswordEvent extends ResetPasswordEvent {
  final String email;
  final String password;
  const GoToResetPasswordEvent(this.email, this.password);
  @override
  List<Object> get props => [email, password];
}
