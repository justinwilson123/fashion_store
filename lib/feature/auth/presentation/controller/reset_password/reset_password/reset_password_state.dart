part of 'reset_password_bloc.dart';

class ResetPasswordState extends Equatable {
  final bool validPass;
  final bool showePass;
  final bool validRepass;
  final bool showeRepass;
  final bool validAll;
  final bool isLoading;
  final String successMessage;
  final String errorMessage;
  const ResetPasswordState(
      {this.validPass = false,
      this.showePass = true,
      this.validRepass = false,
      this.showeRepass = true,
      this.validAll = false,
      this.isLoading = false,
      this.errorMessage = "",
      this.successMessage = ""});

  ResetPasswordState copyWith({
    bool? validPass,
    bool? showePass,
    bool? validRepass,
    bool? showeRepass,
    bool? validAll,
    bool? isLoading,
    String? successMessage,
    String? errorMessage,
  }) {
    return ResetPasswordState(
      validPass: validPass ?? this.validPass,
      showePass: showePass ?? this.showePass,
      validRepass: validRepass ?? this.validRepass,
      showeRepass: showeRepass ?? this.showeRepass,
      validAll: validAll ?? this.validAll,
      isLoading: isLoading ?? this.isLoading,
      successMessage: successMessage ?? this.successMessage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        validPass,
        showePass,
        validRepass,
        showeRepass,
        validAll,
        isLoading,
        successMessage,
        errorMessage,
      ];
}

final class ResetPasswordInitial extends ResetPasswordState {}
