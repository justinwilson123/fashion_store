part of 'verifi_email_bloc.dart';

class VerifiEmailState extends Equatable {
  final bool isCompleated;
  final bool isLoading;
  final String successMessage;
  final String errorMessage;
  final String successResendMessage;
  final String errorResendMessage;
  const VerifiEmailState({
    this.isCompleated = false,
    this.isLoading = false,
    this.successMessage = "",
    this.errorMessage = "",
    this.successResendMessage = "",
    this.errorResendMessage = "",
  });
  VerifiEmailState copywith({
    bool? isCompleated,
    bool? isLoading,
    String? successMessage,
    String? errorMessage,
    String? successResendMessage,
    String? errorResendMessage,
  }) {
    return VerifiEmailState(
      isCompleated: isCompleated ?? this.isCompleated,
      isLoading: isLoading ?? this.isLoading,
      successMessage: successMessage ?? this.successMessage,
      errorMessage: errorMessage ?? this.errorMessage,
      successResendMessage: successResendMessage ?? this.successResendMessage,
      errorResendMessage: errorResendMessage ?? this.errorResendMessage,
    );
  }

  @override
  List<Object> get props => [
        isCompleated,
        isLoading,
        successMessage,
        errorMessage,
        successResendMessage,
        errorResendMessage,
      ];
}

final class VerifiEmailInitial extends VerifiEmailState {}
