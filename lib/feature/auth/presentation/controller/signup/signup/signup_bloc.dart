import 'package:dartz/dartz.dart';
import 'package:fashion/core/services/firebase_auth_service.dart';
import 'package:fashion/feature/auth/data/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/constant/strings/failure_message.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../domain/entities/users.dart';
import '../../../../domain/usecases/sign_up_usecase.dart';
import '../../../../domain/usecases/signup_with_google_usercase.dart';

part 'signup_state.dart';
part 'signup_event.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignUpUsecase signUp;
  final SignupWithGoogleUsercase googleSignup;
  final SignupWithGoogleUsercase signUpWithGoogle;
  final FirebaseAuthService fBAuthService;
  SignupBloc(
    this.signUp,
    this.googleSignup,
    this.signUpWithGoogle,
    this.fBAuthService,
  ) : super(SignupInitialState()) {
    on<SignupEvent>((event, emit) async {
      if (event is ValidateFullNameSignUpEvent) {
        emit(state.copyWith(
            validName: event.fullNameValid,
            errorMessage: "",
            seccessMessage: ""));
        emit(_validAllFiled(
          event.fullNameValid,
          state.validEmail,
          state.validNummberPhone,
          state.validPass,
        ));
        //=====================================================
      } else if (event is ValidateEmailFiledSignupEvent) {
        emit(state.copyWith(
            validEmail: event.emailValidate,
            errorMessage: "",
            seccessMessage: ""));
        emit(_validAllFiled(
          state.validName,
          event.emailValidate,
          state.validNummberPhone,
          state.validPass,
        ));
        //========================================================
      } else if (event is ValidatePhoneSignupEvent) {
        emit(state.copyWith(
            validNummberPhone: true, errorMessage: "", seccessMessage: ""));
        emit(_validAllFiled(
          state.validName,
          state.validEmail,
          event.phoneValid,
          state.validPass,
        ));
        //==========================================================
      } else if (event is ValidatePassFiledSignupEvent) {
        emit(state.copyWith(
            validPass: event.passValidate,
            errorMessage: "",
            seccessMessage: ""));
        emit(_validAllFiled(
          state.validName,
          state.validEmail,
          state.validNummberPhone,
          event.passValidate,
        ));
      } else if (event is ShowAndHidPasswordSignupEvent) {
        emit(state.copyWith(showePass: event.showPass, errorMessage: ""));
        //============================================
      } else if (event is GoSignupEvent) {
        emit(state.copyWith(isLoading: true));
        final user = UserEntite(
          userEmail: event.email,
          userPhone: event.phone,
          userFullName: event.fullName,
          userPassword: event.password,
        );
        final either = await signUp.call(user);
        emit(_failurOrUnit(either, false));
        //===============================================
      } else if (event is SignUpWithGoogleEvent) {
        emit(state.copyWith(errorMessage: "", seccessMessage: ""));
        final user = await fBAuthService.signupWithgoole();
        if (user is UserModel) {
          emit(state.copyWith(isLoading: true));
          final either = await signUpWithGoogle.call(user);
          emit(_failurOrUnit(either, true));
        }
      }
    });
  }

//==============================Function============================
  SignupState _failurOrUnit(
      Either<Failure, Unit> failureOrUnit, bool isGoogle) {
    return failureOrUnit.fold(
      (failure) => state.copyWith(
        errorMessage: _mapFailureToMessage(failure),
        isLoading: false,
      ),
      (_) => state.copyWith(
        isLoading: false,
        seccessMessage: isGoogle
            ? "Your google has been created"
            : "Your account has been created",
      ),
    );
  }

  SignupState _validAllFiled(
      bool fullValid, bool emailValid, bool phoneValid, bool passvalid) {
    return state.copyWith(
      validAllField: fullValid && emailValid && phoneValid && passvalid,
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure == ServerFailure()) {
      return SERVER_FAILURE_MESSAGE;
    } else if (failure == OffLineFailure()) {
      return OFFLINE_FAILURE_MESSAGE;
    } else if (failure == EmailUseingFailure()) {
      return EMAIL_USE;
    } else if (failure == PhoneNumberUseingFailure()) {
      return PHONE_USE;
    } else {
      return "UnExpected Error , please try again later";
    }
  }
}
