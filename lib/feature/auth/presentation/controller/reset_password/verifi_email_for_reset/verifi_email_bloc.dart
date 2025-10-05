import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/constant/strings/failure_message.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../domain/usecases/resend_verifi_code_usercase.dart';
import '../../../../domain/usecases/verifi_email_pass_usercase.dart';

part 'verifi_email_event.dart';
part 'verifi_email_state.dart';

class VerifiEmailBloc extends Bloc<VerifiEmailEvent, VerifiEmailState> {
  final ResendVerifiCodeUsercase resendVerifi;
  final VerifiEmailPassUsercase verifiPass;
  VerifiEmailBloc(this.resendVerifi, this.verifiPass)
      : super(VerifiEmailInitial()) {
    on<VerifiEmailEvent>((event, emit) async {
      if (event is InitVerifiEmailEvent) {
        emit(state.copywith(
          isLoading: false,
          isCompleated: false,
          successMessage: "",
          successResendMessage: "",
          errorMessage: "",
          errorResendMessage: "",
        ));
      } else if (event is CompleatFillFiledCodeEvent) {
        emit(state.copywith(
          isCompleated: event.isValid,
          errorMessage: '',
          errorResendMessage: "",
          successResendMessage: "",
        ));
      } else if (event is ResendVerifiCodeEmail) {
        emit(state.copywith(
            isLoading: true,
            errorMessage: "",
            errorResendMessage: "",
            successResendMessage: ""));
        final faliureOrUnit = await resendVerifi.call(event.email);
        faliureOrUnit.fold(
          (failure) {
            emit(state.copywith(
              errorResendMessage: _mapFailureToMessageForResendVerifi(failure),
              successResendMessage: "",
              errorMessage: "",
              isLoading: false,
            ));
          },
          (_) {
            emit(state.copywith(
              successResendMessage: "Verifi code has been sended to your email",
              errorResendMessage: "",
              errorMessage: "",
              isLoading: false,
            ));
          },
        );
      } else if (event is SendVerifiCodeEvent) {
        emit(state.copywith(isLoading: true));
        final failureOrUnit =
            await verifiPass.call(event.email, event.verifiCode);
        failureOrUnit.fold(
          (failure) {
            emit(
              state.copywith(
                errorMessage: _mapFailureToMessageForVerifiEmail(failure),
                successResendMessage: "",
                errorResendMessage: "",
                isLoading: false,
              ),
            );
          },
          (_) {
            emit(state.copywith(
              successMessage: "Your email has been verified successfully",
            ));
          },
        );
      }
    });
  }
  String _mapFailureToMessageForResendVerifi(Failure failure) {
    if (failure == ServerFailure()) {
      return SERVER_FAILURE_MESSAGE;
    } else if (failure == OffLineFailure()) {
      return OFFLINE_FAILURE_MESSAGE;
    } else if (failure == EmailNotCorrectFailure()) {
      return EMAIL_NOT_CORRECT;
    } else {
      return "UnExpected Error , please try again later";
    }
  }

  String _mapFailureToMessageForVerifiEmail(Failure failure) {
    if (failure == ServerFailure()) {
      return SERVER_FAILURE_MESSAGE;
    } else if (failure == OffLineFailure()) {
      return OFFLINE_FAILURE_MESSAGE;
    } else if (failure == VerifiCodeNotCorrectFailure()) {
      return VERIFI_CODE_NOT_CORRECT;
    } else {
      return "UnExpected Error , please try again later";
    }
  }
}
