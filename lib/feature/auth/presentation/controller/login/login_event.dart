part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class ValidateEmailFiledLogInEvent extends LoginEvent {
  final bool emailValidate;
  const ValidateEmailFiledLogInEvent({required this.emailValidate});
  @override
  List<Object> get props => [emailValidate];
}

class ValidatePassFiledLogInEvent extends LoginEvent {
  final bool passValidate;
  const ValidatePassFiledLogInEvent({required this.passValidate});
  @override
  List<Object> get props => [passValidate];
}

class ShowAndHidPasswordEvent extends LoginEvent {
  final bool showPass;
  const ShowAndHidPasswordEvent(this.showPass);
  @override
  List<Object> get props => [showPass];
}

class GoLoginEvent extends LoginEvent {
  final String email;
  final String password;
  const GoLoginEvent(this.email, this.password);
  @override
  List<Object> get props => [email, password];
}

class GoLoginWithGoogleEvent extends LoginEvent {
  // final String email;
  const GoLoginWithGoogleEvent();
  @override
  List<Object> get props => [];
}

class ReSendVerifiCodeIfNotAproveEvent extends LoginEvent {
  final String email;
  const ReSendVerifiCodeIfNotAproveEvent(this.email);
  @override
  List<Object> get props => [email];
}
