part of 'track_order_bloc.dart';

class TrackOrderState extends Equatable {
  final Map myLocation;
  final bool loadingMap;
  final Map delivery;
  final double latitude;
  final double longitude;
  final String errorMessage;
  const TrackOrderState({
    this.myLocation = const {},
    this.loadingMap = true,
    this.delivery = const {},
    this.errorMessage = "",
    this.latitude = 0.0,
    this.longitude = 0.0,
  });

  TrackOrderState copyWith({
    Map? myLocation,
    Map? delivery,
    String? errorMessage,
    double? latitude,
    double? longitude,
    bool? loadingMap,
  }) {
    return TrackOrderState(
      myLocation: myLocation ?? this.myLocation,
      delivery: delivery ?? this.delivery,
      errorMessage: errorMessage ?? this.errorMessage,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      loadingMap: loadingMap ?? this.loadingMap,
    );
  }

  @override
  List<Object> get props => [
        myLocation,
        loadingMap,
        delivery,
        errorMessage,
        longitude,
        latitude,
      ];
}

final class TrackOrderInitial extends TrackOrderState {}
