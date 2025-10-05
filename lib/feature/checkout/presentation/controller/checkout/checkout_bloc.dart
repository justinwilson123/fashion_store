import 'package:fashion/core/class/cached_user_info.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/checkout/domin/entity/checkout_entities.dart';
import 'package:fashion/feature/checkout/domin/usecase/add_order_usecase.dart';
import 'package:fashion/feature/checkout/domin/usecase/get_all_card_usecase.dart';
import 'package:fashion/feature/checkout/domin/usecase/get_all_location_usecase.dart';
import 'package:fashion/feature/checkout/domin/usecase/get_default_card_usecase.dart';
import 'package:fashion/feature/checkout/domin/usecase/get_default_location_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/constant/strings/failure_message.dart';
import '../../../../../injiction_container.dart' as di;
import '../../../domin/usecase/add_coupon_usecase.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final GetDefaultLocationUsecase getDefaultLocation;
  final GetDefaultCardUsecase getDefaultCard;
  final GetAllCardUsecase getAllCard;
  final GetAllLocationUsecase getAllLocation;
  final AddCouponUsecase addCouponUsecase;
  final AddOrderUsecase addOrder;
  CheckoutBloc(
    this.getDefaultCard,
    this.getDefaultLocation,
    this.getAllCard,
    this.getAllLocation,
    this.addCouponUsecase,
    this.addOrder,
  ) : super(CheckoutInitial()) {
    on<CheckoutEvent>((event, emit) async {
      if (event is GetTotalPrice) {
        emit(
          state.copyWith(
            price: event.price,
            errorMessage: "",
            successAddOrder: "",
            successMessage: "",
          ),
        );
      } else if (event is GetDefaultLoctionEvent) {
        emit(state.copyWith(
          isDefaultLocationLoading: true,
          successAddOrder: "",
          errorMessage: "",
          successMessage: "",
        ));
        final user = await di.sl<CachedUserInfo>().getUserInfo();
        final either = await getDefaultLocation.call(user.userId!);
        either.fold(
          (failure) {
            if (event is NoDataFailure) {
              emit(state.copyWith(
                  locationFind: false, isDefaultLocationLoading: false));
            } else {
              emit(state.copyWith(
                  errorMessage: _mapFailureToMessage(failure),
                  locationFind: false,
                  isDefaultLocationLoading: false));
            }
          },
          (defalutLocation) {
            emit(state.copyWith(
                defaultLocation: defalutLocation,
                groupValueLocation: defalutLocation.locationID,
                locationFind: true,
                isDefaultLocationLoading: false));
          },
        );
        emit(_validOrder(state.locationFind, state.paymentFind));
      } else if (event is GetDefaultCardEvent) {
        emit(state.copyWith(
          isDefaultCardLoading: true,
          errorMessage: "",
          paymentFind: false,
        ));
        emit(_validOrder(state.locationFind, state.paymentFind));
        final user = await di.sl<CachedUserInfo>().getUserInfo();
        final either = await getDefaultCard.call(user.userId!);
        either.fold(
          (failure) {
            if (failure is NoDataFailure) {
              emit(state.copyWith(
                errorMessage: "",
                isDefaultCardLoading: false,
                paymentFind: false,
              ));
            } else {
              emit(state.copyWith(
                errorMessage: _mapFailureToMessage(failure),
                isDefaultCardLoading: false,
                paymentFind: false,
              ));
            }
          },
          (defaultCard) {
            emit(state.copyWith(
              defaultCard: defaultCard,
              groupValueCard: defaultCard.id,
              errorMessage: "",
              isDefaultCardLoading: false,
              paymentFind: true,
            ));
          },
        );
        emit(_validOrder(state.locationFind, state.paymentFind));
      } else if (event is ChangePaymentMethodEvent) {
        emit(state.copyWith(
          indexPayment: event.indexPayment,
          namePayment: event.namePayment,
          errorMessage: "",
          successMessage: "",
          successAddOrder: "",
        ));
        if (event.indexPayment == 0) {
          add(const GetDefaultCardEvent());
        } else {
          emit(_validOrder(state.locationFind, true));
        }
      } else if (event is GetAllCardEvent) {
        emit(state.copyWith(isCardsLoading: true, errorMessage: ""));
        final user = await di.sl<CachedUserInfo>().getUserInfo();
        final either = await getAllCard.call(user.userId!);
        either.fold(
          (failure) {
            if (failure is NoDataFailure) {
              emit(state.copyWith(isCardsLoading: false, paymentFind: false));
            } else {
              emit(state.copyWith(
                errorMessage: _mapFailureToMessage(failure),
                isCardsLoading: false,
                paymentFind: false,
              ));
            }
          },
          (listCard) {
            emit(state.copyWith(
              listCard: listCard,
              isCardsLoading: false,
              paymentFind: true,
            ));
          },
        );
      } else if (event is GetAllLocationEvent) {
        emit(state.copyWith(
          isLocationsLoading: true,
          errorMessage: "",
        ));
        final user = await di.sl<CachedUserInfo>().getUserInfo();
        final either = await getAllLocation.call(user.userId!);
        either.fold(
          (failure) {
            if (failure is NoDataFailure) {
              emit(state.copyWith(isLocationsLoading: false));
            } else {
              emit(state.copyWith(isLocationsLoading: false));
            }
          },
          (listLocation) {
            emit(state.copyWith(
                listLocation: listLocation, isLocationsLoading: false));
          },
        );
      } else if (event is ChangeCardEvent) {
        emit(state.copyWith(
          defaultCard: event.card,
          groupValueCard: event.groupValueCard,
          paymentFind: true,
        ));
        emit(_validOrder(
          state.locationFind,
          state.paymentFind,
        ));
      } else if (event is ChangeLocationEvent) {
        emit(state.copyWith(
          defaultLocation: event.location,
          groupValueLocation: event.groupValueLocation,
          locationFind: true,
        ));
        emit(_validOrder(
          state.locationFind,
          state.paymentFind,
        ));
      } else if (event is ValidCouponFieldEvent) {
        emit(state.copyWith(
          errorMessage: "",
          validCoupon: event.isValid,
          couponName: event.couponName,
        ));
      } else if (event is AddCouponEvent) {
        emit(
            state.copyWith(errorMessage: "", couponLoading: true, discount: 0));
        final either = await addCouponUsecase.call(state.couponName);
        either.fold(
          (failure) {
            emit(state.copyWith(
              errorMessage: _mapFailureToMessage(failure),
              couponLoading: false,
            ));
          },
          (discount) {
            emit(state.copyWith(
              couponLoading: false,
              discount: discount,
              errorMessage: '',
            ));
          },
        );
      } else if (event is AddOrderEvent) {
        emit(state.copyWith(
          errorMessage: "",
          successMessage: "",
          addOrderLoading: true,
        ));
        final user = await di.sl<CachedUserInfo>().getUserInfo();
        final either = await addOrder.call(
          user.userId!,
          state.defaultLocation.locationID,
          state.namePayment,
          state.discount,
          ((state.price * 0.013).ceil() + state.price) -
              ((state.price * state.discount / 100).ceil()),
        );
        either.fold(
          (failure) {
            emit(state.copyWith(
                errorMessage: _mapFailureToMessage(failure),
                addOrderLoading: false));
          },
          (_) {
            emit(state.copyWith(
              successAddOrder: "success",
              successMessage: "",
              errorMessage: "",
              addOrderLoading: false,
            ));
          },
        );
      }
    });
  }
  CheckoutState _validOrder(bool location, bool payment) {
    return state.copyWith(validOrder: location && payment);
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure == ServerFailure()) {
      return SERVER_FAILURE_MESSAGE;
    } else if (failure == OffLineFailure()) {
      return OFFLINE_FAILURE_MESSAGE;
    } else if (failure == NoDataFailure()) {
      return "Not Found this coupon maybe it is ended";
    } else {
      return "UnExpected Error , please try again later";
    }
  }
}
