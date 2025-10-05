part of 'add_location_bloc.dart';

sealed class AddLocationEvent extends Equatable {
  const AddLocationEvent();

  @override
  List<Object> get props => [];
}

class AddNewLocationEvent extends AddLocationEvent {
  final LocationEntity location;
  const AddNewLocationEvent(this.location);
  @override
  List<Object> get props => [location];
}

class ValidNameLocationEvent extends AddLocationEvent {
  final bool validName;
  const ValidNameLocationEvent(this.validName);
  @override
  List<Object> get props => [validName];
}

class ValidFullAddressLocationEvent extends AddLocationEvent {
  final bool validFullAddress;
  const ValidFullAddressLocationEvent(this.validFullAddress);
  @override
  List<Object> get props => [];
}

class DefaultLocationEvent extends AddLocationEvent {
  final bool isDefault;
  const DefaultLocationEvent(this.isDefault);
  @override
  List<Object> get props => [isDefault];
}

class AddMarkerEvent extends AddLocationEvent {
  final double latitude;
  final double longitude;
  const AddMarkerEvent(
    this.latitude,
    this.longitude,
  );
  @override
  List<Object> get props => [
        latitude,
        longitude,
      ];
}

class GetMyLocationEvent extends AddLocationEvent {
  const GetMyLocationEvent();
  @override
  List<Object> get props => [];
}
