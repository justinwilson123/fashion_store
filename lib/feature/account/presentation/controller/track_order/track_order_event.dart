part of 'track_order_bloc.dart';

sealed class TrackOrderEvent extends Equatable {
  const TrackOrderEvent();

  @override
  List<Object> get props => [];
}

class GetMyLocationEvent extends TrackOrderEvent {
  final int locationID;
  const GetMyLocationEvent(this.locationID);
  @override
  List<Object> get props => [locationID];
}

class GetDeliveryDetailsEvent extends TrackOrderEvent {
  final int deliveryID;
  const GetDeliveryDetailsEvent(this.deliveryID);
  @override
  List<Object> get props => [deliveryID];
}
