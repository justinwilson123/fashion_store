part of 'enter_email_bloc.dart';

class EnterEmailState extends Equatable {
  final bool isValidEmail;
  final String successMessage;
  final String errorMessage;
  final bool isLoading;
  const EnterEmailState({
    this.isValidEmail = false,
    this.errorMessage = "",
    this.successMessage = "",
    this.isLoading = false,
  });

  EnterEmailState copyWith({
    bool? isValidEmail,
    String? successMessage,
    String? errorMessage,
    bool? isLoading,
  }) {
    return EnterEmailState(
      isValidEmail: isValidEmail ?? this.isValidEmail,
      isLoading: isLoading ?? this.isLoading,
      successMessage: successMessage ?? this.successMessage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props =>
      [isValidEmail, successMessage, errorMessage, isLoading];
}

final class EnterEmailInitial extends EnterEmailState {}
