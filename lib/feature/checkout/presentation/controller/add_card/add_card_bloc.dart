// import 'package:fashion/core/class/cached_user_info.dart';
import 'package:fashion/feature/checkout/domin/entity/checkout_entities.dart';
import 'package:fashion/feature/checkout/domin/usecase/add_card_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/constant/strings/failure_message.dart';
import '../../../../../core/error/failure.dart';
// import '../../../../../injiction_container.dart' as di;

part 'add_card_event.dart';
part 'add_card_state.dart';

class AddCardBloc extends Bloc<AddCardEvent, AddCardState> {
  final AddCardUsecase addCard;

  AddCardBloc(this.addCard) : super(AddCardInitial()) {
    on<AddCardEvent>((event, emit) async {
      if (event is ValidCardNumberEvent) {
        emit(state.copyWith(
          validCardNumder: event.isValidCardNumber,
          errorMessage: "",
          successMessage: "",
        ));
        emit(_validAll(event.isValidCardNumber, state.validPamentMethed,
            state.validCardBrand));
      } else if (event is ValidCardBrandEvent) {
        emit(state.copyWith(
          validCardBrand: event.isValidCarBrand,
          errorMessage: "",
          successMessage: "",
        ));
        emit(_validAll(state.validCardNumder, state.validPamentMethed,
            event.isValidCarBrand));
      } else if (event is ValidPaymentMethodEvent) {
        emit(state.copyWith(
          validPamentMethed: event.isValidPaymentMethod,
          errorMessage: "",
          successMessage: "",
        ));
        emit(_validAll(state.validCardNumder, event.isValidPaymentMethod,
            state.validCardBrand));
      } else if (event is DefaultCardEvent) {
        emit(state.copyWith(
          isDefault: !event.isDefault,
          errorMessage: "",
          successMessage: "",
        ));
      } else if (event is AddNewCardEvent) {
        emit(state.copyWith(isLoading: true));
        final either = await addCard.call(event.card);
        either.fold(
          (failure) {
            emit(state.copyWith(
              errorMessage: _mapFailureToMessage(failure),
              isLoading: false,
            ));
          },
          (_) {
            emit(state.copyWith(
              errorMessage: "",
              successMessage: "Your card has been added",
              isLoading: false,
            ));
          },
        );
      }
    });
  }

  AddCardState _validAll(bool cardNumber, bool paymentMethod, bool cardBarnd) {
    return state.copyWith(
      validAll: cardNumber && paymentMethod && cardNumber,
      errorMessage: "",
    );
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
