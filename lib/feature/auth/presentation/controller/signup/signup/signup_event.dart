part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class ValidateEmailFiledSignupEvent extends SignupEvent {
  final bool emailValidate;
  const ValidateEmailFiledSignupEvent({required this.emailValidate});
  @override
  List<Object> get props => [emailValidate];
}

class ValidatePassFiledSignupEvent extends SignupEvent {
  final bool passValidate;
  const ValidatePassFiledSignupEvent({required this.passValidate});
  @override
  List<Object> get props => [passValidate];
}

class ValidateFullNameSignUpEvent extends SignupEvent {
  final bool fullNameValid;
  const ValidateFullNameSignUpEvent(this.fullNameValid);
  @override
  List<Object> get props => [fullNameValid];
}

class ValidatePhoneSignupEvent extends SignupEvent {
  final bool phoneValid;
  const ValidatePhoneSignupEvent(this.phoneValid);
  @override
  List<Object> get props => [phoneValid];
}

class ShowAndHidPasswordSignupEvent extends SignupEvent {
  final bool showPass;
  const ShowAndHidPasswordSignupEvent(this.showPass);
  @override
  List<Object> get props => [showPass];
}

class GoSignupEvent extends SignupEvent {
  final String fullName;
  final String email;
  final String phone;
  final String password;
  const GoSignupEvent(this.fullName, this.email, this.phone, this.password);
  @override
  List<Object> get props => [email, password];
}

class SignUpWithGoogleEvent extends SignupEvent {
  const SignUpWithGoogleEvent();
  @override
  List<Object> get props => [];
}

class SignUpWithFacebookEvent extends SignupEvent {}
