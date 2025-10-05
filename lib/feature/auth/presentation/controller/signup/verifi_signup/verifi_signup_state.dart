import 'package:equatable/equatable.dart';

class VerifiSignupState extends Equatable {
  final String errorVerifiMessage;
  final String successVerifiMessage;
  final String errorResendVerifiMessage;
  final String successResendVerifiMessage;
  final bool isCompleated;
  final bool isLoading;
  const VerifiSignupState({
    this.errorVerifiMessage = "",
    this.successVerifiMessage = "",
    this.successResendVerifiMessage = "",
    this.errorResendVerifiMessage = "",
    this.isCompleated = false,
    this.isLoading = false,
  });

  VerifiSignupState copyWith({
    String? errorVerifiMessage,
    String? successVerifiMessage,
    String? successResendVerifiMessage,
    String? errorResendVerifiMessage,
    bool? isCompleated,
    bool? isLoading,
  }) {
    return VerifiSignupState(
      errorVerifiMessage: errorVerifiMessage ?? this.errorVerifiMessage,
      successVerifiMessage: successVerifiMessage ?? this.successVerifiMessage,
      successResendVerifiMessage:
          successResendVerifiMessage ?? this.successResendVerifiMessage,
      errorResendVerifiMessage:
          errorResendVerifiMessage ?? this.errorResendVerifiMessage,
      isCompleated: isCompleated ?? this.isCompleated,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [
        errorVerifiMessage,
        successVerifiMessage,
        successResendVerifiMessage,
        errorResendVerifiMessage,
        isCompleated,
        isLoading,
      ];
}

final class VerifiSignupInitial extends VerifiSignupState {}
