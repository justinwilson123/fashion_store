import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/constant/strings/failure_message.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../domain/usecases/reset_password_usecase.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ResetPasswordUsecase resetPassword;
  ResetPasswordBloc(this.resetPassword) : super(ResetPasswordInitial()) {
    on<ResetPasswordEvent>((event, emit) async {
      if (event is ValidPasswordFiledEvent) {
        emit(state.copyWith(
            validPass: event.isValidPass,
            errorMessage: "",
            successMessage: ""));
        emit(_validAll(event.isValidPass, state.validRepass));
      } else if (event is ValidRePasswordFiledEvent) {
        emit(state.copyWith(
            validRepass: event.isValisRepass,
            errorMessage: "",
            successMessage: ""));
        emit(_validAll(state.validPass, event.isValisRepass));
      } else if (event is ShowePasswordEvent) {
        emit(state.copyWith(
          showePass: event.showePass,
          errorMessage: "",
          successMessage: "",
        ));
      } else if (event is ShoweRePasswordEvent) {
        emit(state.copyWith(
            showeRepass: event.showeRepass,
            errorMessage: "",
            successMessage: ""));
      } else if (event is GoToResetPasswordEvent) {
        emit(state.copyWith(isLoading: true, errorMessage: ""));
        final failureOrUnit =
            await resetPassword.call(event.email, event.password);
        failureOrUnit.fold(
          (failure) {
            emit(state.copyWith(
                isLoading: false, errorMessage: _mapFailureToMessage(failure)));
          },
          (_) {
            emit(state.copyWith(
                validAll: false,
                validPass: false,
                validRepass: false,
                isLoading: false,
                successMessage:
                    "Your Password has been changed you can login"));
          },
        );
      }
    });
  }
  ResetPasswordState _validAll(bool validpass, bool validRepass) {
    if (validpass && validRepass) {
      return state.copyWith(validAll: true);
    } else {
      return state.copyWith(validAll: false);
    }
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure == ServerFailure()) {
      return SERVER_FAILURE_MESSAGE;
    } else if (failure == OffLineFailure()) {
      return OFFLINE_FAILURE_MESSAGE;
    } else if (failure == EmailNotCorrectFailure()) {
      return ERROR_RESET_PASSWORD;
    } else {
      return "UnExpected Error , please try again later";
    }
  }
}
