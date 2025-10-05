part of 'signup_bloc.dart';

class SignupState extends Equatable {
  final String errorMessage;
  final bool isLoading;
  final bool validName;
  final bool validNummberPhone;
  final String seccessMessage;
  final bool validAllField;
  final bool validEmail;
  final bool validPass;
  final bool showePass;

  const SignupState({
    this.errorMessage = "",
    this.seccessMessage = "",
    this.isLoading = false,
    this.validName = false,
    this.validNummberPhone = false,
    this.validEmail = false,
    this.validAllField = false,
    this.validPass = false,
    this.showePass = true,
  });

  SignupState copyWith({
    String? errorMessage,
    String? seccessMessage,
    bool? isLoading,
    bool? validEmail,
    bool? validPass,
    bool? showePass,
    bool? validName,
    bool? validNummberPhone,
    bool? validAllField,
  }) {
    return SignupState(
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      validEmail: validEmail ?? this.validEmail,
      validPass: validPass ?? this.validPass,
      validName: validName ?? this.validName,
      validNummberPhone: validNummberPhone ?? this.validNummberPhone,
      seccessMessage: seccessMessage ?? this.seccessMessage,
      showePass: showePass ?? this.showePass,
      validAllField: validAllField ?? this.validAllField,
    );
  }

  @override
  List<Object> get props => [
        errorMessage,
        seccessMessage,
        validName,
        validNummberPhone,
        isLoading,
        validEmail,
        validPass,
        showePass,
        validAllField,
      ];
}

final class SignupInitialState extends SignupState {}
