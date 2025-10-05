import 'package:fashion/core/class/cached_user_info.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/account/domain/usecase/order/get_order_completed_usecase.dart';
import 'package:fashion/feature/account/domain/usecase/order/get_oreder_ongoing_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constant/strings/failure_message.dart';
import '../../../domain/entities/order_entity.dart';
import '../../../../../injiction_container.dart' as di;
import '../../../domain/usecase/order/rating_order_usecase.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetOrederOngoingUsecase orderOnGoing;
  final GetOrderCompletedUsecase orderCompleted;
  final RatingOrderUsecase ratingOrder;

  int page = 0;
  OrderBloc(
    this.orderOnGoing,
    this.orderCompleted,
    this.ratingOrder,
  ) : super(OrderInitial()) {
    on<OrderEvent>((event, emit) async {
      if (event is GetOrederOngoingEvent) {
        emit(state.copyWith(
          orderOngoinStatus: OrderOngoinStatus.loading,
          errorMessage: "",
          orderOngoing: [],
        ));
        final user = await di.sl<CachedUserInfo>().getUserInfo();
        final either = await orderOnGoing.call(user.userId!);
        either.fold(
          (failure) {
            if (failure is NoDataFailure) {
              emit(state.copyWith(orderOngoinStatus: OrderOngoinStatus.noData));
            } else {
              emit(state.copyWith(
                orderOngoinStatus: OrderOngoinStatus.noData,
                errorMessage: _mapFailureToMessage(failure),
              ));
            }
          },
          (order) {
            emit(state.copyWith(
              orderOngoinStatus: OrderOngoinStatus.loaded,
              orderOngoing: order,
              errorMessage: "",
            ));
          },
        );
      } else if (event is TranBetweenOngingCompletedEvent) {
        emit(state.copyWith(errorMessage: "", initIndex: event.index));
      } else if (event is GetOrederCompletedEvent) {
        if (state.hasRechedMax) return;
        page += 1;
        emit(state.copyWith(
          orderCompletedStatus: OrderCompletedStatus.loading,
          errorMessage: "",
        ));
        final user = await di.sl<CachedUserInfo>().getUserInfo();
        final either = await orderCompleted.call(user.userId!, page);
        either.fold(
          (failure) {
            if (failure is NoDataFailure) {
              emit(state.copyWith(
                orderCompletedStatus: OrderCompletedStatus.noData,
                hasRechedMax: true,
              ));
            } else {
              emit(state.copyWith(
                errorMessage: _mapFailureToMessage(failure),
                orderCompletedStatus: OrderCompletedStatus.noData,
              ));
            }
          },
          (order) {
            order.length >= 10
                ? emit(state.copyWith(
                    orderCompletedStatus: OrderCompletedStatus.loaded,
                    errorMessage: "",
                    orderCompleted: List.of(state.orderCompleted)
                      ..addAll(order),
                  ))
                : emit(state.copyWith(
                    orderCompletedStatus: OrderCompletedStatus.loaded,
                    errorMessage: "",
                    hasRechedMax: true,
                    orderCompleted: List.of(state.orderCompleted)
                      ..addAll(order),
                  ));
          },
        );
      } else if (event is RefreshOrderCompletedEvent) {
        page = 0;
        emit(state.copyWith(orderCompleted: [], hasRechedMax: false));
        add(const GetOrederCompletedEvent());
      } else if (event is ChangeStarRatingEvent) {
        emit(state.copyWith(errorMessage: "", indexStar: event.index));
      } else if (event is RatingOrderEvent) {
        emit(state.copyWith(errorMessage: "", loadingRating: true));
        final upDateOrderCompleted =
            List<OrderEntity>.from(state.orderCompleted);
        final index = upDateOrderCompleted.indexWhere((order) =>
            order.orderID == event.orderID &&
            order.colorID == event.colorID &&
            order.sizeID == event.sizeID);
        if (index != -1) {
          final user = await di.sl<CachedUserInfo>().getUserInfo();
          final either = await ratingOrder.call(
            user.userId!,
            event.productID,
            event.comment,
            state.indexStar + 1,
            event.orderID,
            event.sizeID,
            event.colorID,
          );
          either.fold(
            (failure) {
              print(failure);
              emit(state.copyWith(
                  errorMessage: _mapFailureToMessage(failure),
                  loadingRating: false));
            },
            (_) {
              final updateOrder = upDateOrderCompleted[index].copyWith(
                isRating: 1,
                rating: state.indexStar + 1,
              );
              upDateOrderCompleted[index] = updateOrder;
              emit(state.copyWith(
                orderCompleted: upDateOrderCompleted,
                errorMessage: "",
                loadingRating: false,
              ));
            },
          );
        } else {
          print("not found index");
          emit(state.copyWith(loadingRating: false));
        }
      }
    });
  }
  String _mapFailureToMessage(Failure failure) {
    if (failure == ServerFailure()) {
      return SERVER_FAILURE_MESSAGE;
    } else if (failure == OffLineFailure()) {
      return OFFLINE_FAILURE_MESSAGE;
    } else if (failure is NoDataFailure) {
      return "";
    } else {
      return "UnExpected Error , please try again later";
    }
  }
}
