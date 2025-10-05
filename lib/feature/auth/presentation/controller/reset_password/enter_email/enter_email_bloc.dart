import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/constant/strings/failure_message.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../domain/usecases/enter_email_usercase.dart';

part 'enter_email_event.dart';
part 'enter_email_state.dart';

class EnterEmailBloc extends Bloc<EnterEmailEvent, EnterEmailState> {
  final EnterEmailUsercase enterEmail;
  EnterEmailBloc(this.enterEmail) : super(EnterEmailInitial()) {
    on<EnterEmailEvent>((event, emit) async {
      if (event is ValidEmailFaildEvent) {
        emit(state.copyWith(
            isValidEmail: event.validEmail,
            successMessage: "",
            errorMessage: ""));
      } else if (event is SendEamilForSendVerifiCode) {
        emit(state.copyWith(isLoading: true));
        final failureOrUnit = await enterEmail.call(event.email);
        failureOrUnit.fold(
          (failure) {
            emit(state.copyWith(
                isLoading: false, errorMessage: _mapFailureToMessage(failure)));
          },
          (_) {
            emit(state.copyWith(
                isValidEmail: false,
                isLoading: false,
                errorMessage: "",
                successMessage: "Verifi Code has been sended for you email"));
          },
        );
      }
    });
  }
  String _mapFailureToMessage(Failure failure) {
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
}
