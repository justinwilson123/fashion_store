import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:flutter_map/flutter_map.dart';
import '../../../../../core/constant/strings/failure_message.dart';
import '../../../../../core/error/failure.dart';
import '../../../domain/usecase/order/get_delivery_details_usecase.dart';
import '../../../domain/usecase/order/get_my_location_usercase.dart';
// import '../../../../../injiction_container.dart' as di;
part 'track_order_event.dart';
part 'track_order_state.dart';

class TrackOrderBloc extends Bloc<TrackOrderEvent, TrackOrderState> {
  final GetMyLocationUsecase getMyLocation;
  final GetDeliveryDetailsUsecase getDeliveryDetails;
  // final MapController _map = di.sl<MapController>();
  TrackOrderBloc(this.getMyLocation, this.getDeliveryDetails)
      : super(TrackOrderInitial()) {
    on<TrackOrderEvent>((event, emit) async {
      if (event is GetMyLocationEvent) {
        final eihter = await getMyLocation.call(event.locationID);
        eihter.fold(
          (failure) {
            emit(state.copyWith(
              errorMessage: _mapFailureToMessage(failure),
            ));
          },
          (myLocation) {
            print(myLocation);
            emit(state.copyWith(myLocation: myLocation, loadingMap: false));
          },
        );
      } else if (event is GetDeliveryDetailsEvent) {
        final either = await getDeliveryDetails.call(event.deliveryID);
        either.fold(
          (failure) {
            emit(state.copyWith(errorMessage: _mapFailureToMessage(failure)));
          },
          (delivery) {
            print(delivery);
            emit(state.copyWith(delivery: delivery));
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
    } else if (failure is NoDataFailure) {
      return "";
    } else {
      return "UnExpected Error , please try again later";
    }
  }
}
