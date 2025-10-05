import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constant/strings/failure_message.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../domain/usecases/resend_verifi_code_usercase.dart';
import '../../../../domain/usecases/verifi_user_email_usercase.dart';
import 'verifi_signup_event.dart';
import 'verifi_signup_state.dart';

class VerifiSignupBloc extends Bloc<VerifiSignupEvent, VerifiSignupState> {
  final ResendVerifiCodeUsercase resendVerifiCode;
  final VerifiUserEmailUsercase verifiSignup;
  VerifiSignupBloc(this.resendVerifiCode, this.verifiSignup)
      : super(VerifiSignupInitial()) {
    on<VerifiSignupEvent>((event, emit) async {
      if (event is CompleatFillFiledVerifiCodeEvent) {
        emit(state.copyWith(
          isCompleated: event.validFiled,
          errorVerifiMessage: "",
          errorResendVerifiMessage: "",
          successResendVerifiMessage: "",
        ));
      } else if (event is ResendVerifiCodeEvent) {
        emit(state.copyWith(
          isLoading: true,
          errorVerifiMessage: "",
        ));
        final failureOrUnit = await resendVerifiCode.call(event.email);
        failureOrUnit.fold(
          (failure) {
            emit(state.copyWith(
              errorResendVerifiMessage:
                  _mapFailureToMessageForResendVerifi(failure),
              successResendVerifiMessage: "",
              errorVerifiMessage: "",
              isLoading: false,
            ));
          },
          (_) {
            emit(state.copyWith(
              successResendVerifiMessage:
                  "Verifi code has been sended to your email",
              errorResendVerifiMessage: "",
              errorVerifiMessage: "",
              isLoading: false,
            ));
          },
        );
      } else if (event is SendVerifiCodeForVerifiEmailEvent) {
        emit(state.copyWith(isLoading: true));
        final failureOrUnit =
            await verifiSignup.call(event.email, event.verifiCode);
        failureOrUnit.fold(
          (failure) {
            emit(
              state.copyWith(
                errorVerifiMessage: _mapFailureToMessageForVerifiEmail(failure),
                successResendVerifiMessage: "",
                errorResendVerifiMessage: "",
                isLoading: false,
              ),
            );
          },
          (_) {
            emit(state.copyWith(
              successVerifiMessage: "Your email has been verified successfully",
              isLoading: false,
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
