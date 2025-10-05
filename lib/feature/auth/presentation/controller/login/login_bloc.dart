import 'package:dartz/dartz.dart';
import 'package:fashion/core/class/seen_secreen.dart';
import 'package:fashion/core/constant/name_app_route.dart';
import 'package:fashion/core/services/firebase_auth_service.dart';
import 'package:fashion/feature/auth/data/models/user_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/class/cached_user_info.dart';
import '../../../../../core/constant/strings/failure_message.dart';
import '../../../../../core/error/failure.dart';
import '../../../domain/entities/users.dart';
import '../../../domain/usecases/log_in_usercase.dart';
import '../../../domain/usecases/login_with_google_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  static final TextEditingController email = TextEditingController();
  static final TextEditingController password = TextEditingController();
  final LogInUsercase login;
  final CachedUserInfo cashedUserInfo;
  final LoginWithGoogleUsecase googleLogin;
  final FirebaseAuthService firebaseAuthService;
  final SeenSecreen seenSecreen;
  LoginBloc(
    this.login,
    this.googleLogin,
    this.cashedUserInfo,
    this.firebaseAuthService,
    this.seenSecreen,
  ) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is ValidateEmailFiledLogInEvent) {
        final validEmail = event.emailValidate;
        emit(state.copyWith(
            validEmail: validEmail, errorMessage: "", successMessage: ""));
        emit(_validAll(event.emailValidate, state.validPass));
        //==========================================================
      } else if (event is ValidatePassFiledLogInEvent) {
        final validPass = event.passValidate;
        emit(state.copyWith(
            validPass: validPass, errorMessage: "", successMessage: ""));
        emit(_validAll(state.validEmail, event.passValidate));
        //==========================================================
      } else if (event is ShowAndHidPasswordEvent) {
        final showePass = event.showPass;
        emit(state.copyWith(
            showePass: showePass, errorMessage: "", successMessage: ""));
        //===========================================================
      } else if (event is GoLoginEvent) {
        emit(state.copyWith(isLoading: true));
        final either = await login.call(event.email, event.password);

        emit(_failureOrunit(either));
        //===========================================================
      } else if (event is GoLoginWithGoogleEvent) {
        emit(state.copyWith(errorMessage: "", successMessage: ""));
        final user = await firebaseAuthService.loginWithgoole();
        if (user is UserModel) {
          emit(state.copyWith(isLoading: true));
          final either = await googleLogin.call(user.userEmail);

          emit(_failureOrunit(either));
        }

        //================================================================
      }
    });
  }
//=========================Function========================================
  LoginState _failureOrunit(Either<Failure, UserEntite> either) {
    return either.fold((failure) {
      return state.copyWith(
        isLoading: false,
        errorMessage: _mapFailureToMessage(failure),
        successMessage: "",
      );
    }, (user) {
      cashedUserInfo.cachedUserInfo(user);
      seenSecreen.saveSeenScreen(NameAppRoute.login);
      return state.copyWith(
        isLoading: false,
        errorMessage: "",
        successMessage: "seccess",
      );
    });
  }

  LoginState _validAll(bool validEmail, bool validPass) {
    return state.copyWith(
      validAllField: validEmail && validPass,
      errorMessage: "",
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure == ServerFailure()) {
      return SERVER_FAILURE_MESSAGE;
    } else if (failure == OffLineFailure()) {
      return OFFLINE_FAILURE_MESSAGE;
    } else if (failure == EmailNotCorrectFailure()) {
      return EMAIL_OR_PASS_NOT_CORRECT;
    } else if (failure == EmailNotVerifitFailure()) {
      return EMAIL_NOT_VERIFIED;
    } else if (failure == EmailIsNotRegisteredFailure()) {
      return EMAIL_IS_NOT_REGISTERED;
    } else {
      return "UnExpected Error , please try again later";
    }
  }

  @override
  Future<void> close() {
    email.clear();
    password.clear();
    return super.close();
  }
}
