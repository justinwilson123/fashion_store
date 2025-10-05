part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String errorMessage;
  final String seccessMessage;
  final bool isLoading;
  final bool validAllField;
  final bool validEmail;
  final bool validPass;
  final bool showePass;

  const LoginState({
    this.errorMessage = "",
    this.seccessMessage = "",
    this.isLoading = false,
    this.validEmail = false,
    this.validAllField = false,
    this.validPass = false,
    this.showePass = true,
  });

  LoginState copyWith({
    String? errorMessage,
    String? successMessage,
    bool? isLoading,
    bool? validEmail,
    bool? validPass,
    bool? showePass,
    bool? validAllField,
  }) {
    return LoginState(
      errorMessage: errorMessage ?? this.errorMessage,
      seccessMessage: successMessage ?? this.seccessMessage,
      isLoading: isLoading ?? this.isLoading,
      validEmail: validEmail ?? this.validEmail,
      validPass: validPass ?? this.validPass,
      showePass: showePass ?? this.showePass,
      validAllField: validAllField ?? this.validAllField,
    );
  }

  @override
  List<Object> get props => [
        errorMessage,
        seccessMessage,
        isLoading,
        validEmail,
        validPass,
        showePass,
        validAllField,
      ];
}

final class LoginInitial extends LoginState {}
