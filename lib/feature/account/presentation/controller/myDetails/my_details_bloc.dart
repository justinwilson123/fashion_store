import 'package:country_picker/country_picker.dart';
import 'package:fashion/feature/account/domain/entities/my_details_entity.dart';
import 'package:fashion/feature/account/domain/usecase/mydetails/up_date_my_details_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/class/cached_user_info.dart';
import '../../../../../core/constant/strings/failure_message.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../injiction_container.dart' as di;
import '../../../../auth/domain/entities/users.dart';

part 'my_details_event.dart';
part 'my_details_state.dart';

class MyDetailsBloc extends Bloc<MyDetailsEvent, MyDetailsState> {
  final UpDateMyDetailsUsecase update;

  MyDetailsBloc(this.update) : super(MyDetailsInitial()) {
    on<MyDetailsEvent>((event, emit) async {
      if (event is ChoosYourCountryEvent) {
        emit(state.copyWith(
            flagEmoji: event.flagEmoji,
            phoneCode: event.phoneCode,
            errorMessage: "",
            successMessage: ""));
      } else if (event is UpDateMyDetailsEvent) {
        emit(state.copyWith(
            loadingUpdate: true, errorMessage: "", successMessage: ""));
        final either = await update.call(event.myDetails);
        either.fold(
          (failure) {
            emit(state.copyWith(
                errorMessage: _mapFailureToMessage(failure),
                loadingUpdate: false));
          },
          (_) {
            final UserEntite userEntite = UserEntite(
              userId: event.myDetails.userID,
              userEmail: event.myDetails.email,
              userFullName: event.myDetails.fullName,
              userImage: event.userImage,
              birth: event.myDetails.brith,
              gender: event.myDetails.gender,
              userPhone: event.myDetails.phone,
            );
            di.sl<CachedUserInfo>().cachedUserInfo(userEntite);
            emit(state.copyWith(
              loadingUpdate: false,
              errorMessage: "",
              successMessage: "Your details has been changed successflly",
            ));
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
    } else {
      return "UnExpected Error , please try again later";
    }
  }
}
