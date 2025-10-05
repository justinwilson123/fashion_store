part of 'add_location_bloc.dart';

class AddLocationState extends Equatable {
  final List<Marker> markers;
  final bool getMyLocationLoading;
  final String successMessage;
  final String errorMessage;
  final bool validName;
  final bool validFullName;
  final bool validAll;
  final bool isDefault;
  final bool isLoading;
  final double latitude;
  final double longitude;

  const AddLocationState({
    this.markers = const [],
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.getMyLocationLoading = false,
    this.successMessage = "",
    this.errorMessage = "",
    this.validName = false,
    this.validFullName = false,
    this.validAll = false,
    this.isDefault = false,
    this.isLoading = false,
  });

  AddLocationState copyWith({
    List<Marker>? markers,
    bool? getMyLocationLoading,
    double? latitude,
    double? longitude,
    String? successMessage,
    String? errorMessage,
    bool? validName,
    bool? validFullName,
    bool? validAll,
    bool? isDefault,
    bool? isLoading,
  }) {
    return AddLocationState(
      markers: markers ?? this.markers,
      getMyLocationLoading: getMyLocationLoading ?? this.getMyLocationLoading,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      successMessage: successMessage ?? this.successMessage,
      errorMessage: errorMessage ?? this.errorMessage,
      validName: validName ?? this.validName,
      validFullName: validFullName ?? this.validFullName,
      validAll: validAll ?? this.validAll,
      isDefault: isDefault ?? this.isDefault,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [
        markers,
        getMyLocationLoading,
        latitude,
        longitude,
        successMessage,
        errorMessage,
        validName,
        validFullName,
        validAll,
        isDefault,
        isLoading,
      ];
}

final class AddLocationInitial extends AddLocationState {}
