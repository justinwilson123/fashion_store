import 'package:fashion/core/services/location_services.dart';
import 'package:fashion/feature/checkout/domin/usecase/add_location_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../../../../../core/constant/strings/failure_message.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../injiction_container.dart' as di;
import '../../../domin/entity/checkout_entities.dart';

part 'add_location_event.dart';
part 'add_location_state.dart';

class AddLocationBloc extends Bloc<AddLocationEvent, AddLocationState> {
  final AddLocationUsecase addLocation;
  final MapController map;
  final LocationServices locationServices;
  AddLocationBloc(this.addLocation, this.map, this.locationServices)
      : super(AddLocationInitial()) {
    on<AddLocationEvent>((event, emit) async {
      if (event is ValidNameLocationEvent) {
        emit(state.copyWith(
            validName: event.validName, errorMessage: "", successMessage: ""));
        emit(_validAll(
            event.validName, state.validFullName, state.markers.isNotEmpty));
      } else if (event is ValidFullAddressLocationEvent) {
        emit(state.copyWith(
            validFullName: event.validFullAddress,
            errorMessage: "",
            successMessage: ""));
        emit(_validAll(
            state.validName, event.validFullAddress, state.markers.isNotEmpty));
      } else if (event is AddMarkerEvent) {
        emit(state.copyWith(markers: [], errorMessage: "", successMessage: ""));
        final List<Marker> markers = [
          Marker(
              point: LatLng(event.latitude, event.longitude),
              child: const Icon(
                Icons.location_on,
                color: Colors.red,
              ))
        ];

        emit(state.copyWith(
          markers: markers,
          latitude: event.latitude,
          longitude: event.longitude,
        ));
        map.move(LatLng(event.latitude, event.longitude), 14);
      } else if (event is GetMyLocationEvent) {
        emit(state.copyWith(
            getMyLocationLoading: true, errorMessage: "", successMessage: ""));
        final permission = await di.sl<LocationServices>().determinePosition();

        if (permission ==
            StatuesPermission.serverLocationEnabeldAndPermission) {
          final Position position =
              await di.sl<LocationServices>().getPosition();
          emit(state.copyWith(markers: []));
          final List<Marker> markers = [
            Marker(
                point: LatLng(position.latitude, position.longitude),
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                ))
          ];

          emit(state.copyWith(
              getMyLocationLoading: false,
              markers: markers,
              latitude: position.latitude,
              longitude: position.longitude,
              errorMessage: ""));
          map.move(LatLng(position.latitude, position.longitude), 14);
        } else {
          emit(state.copyWith(
            errorMessage: _mapGeolectorMessage(permission),
            getMyLocationLoading: false,
          ));
        }
      } else if (event is AddNewLocationEvent) {
        emit(state.copyWith(
            isLoading: true, errorMessage: "", successMessage: ""));
        final either = await addLocation.call(event.location);
        either.fold(
          (failure) {
            emit(state.copyWith(
              errorMessage: _mapFailureToMessage(failure),
              isLoading: false,
              successMessage: "",
            ));
          },
          (_) {
            emit(state.copyWith(
              errorMessage: "",
              successMessage: "success",
              isLoading: false,
            ));
          },
        );
        emit(state.copyWith(isLoading: false));
      } else if (event is DefaultLocationEvent) {
        emit(state.copyWith(
            isDefault: !event.isDefault, errorMessage: "", successMessage: ""));
      }
    });
  }

  AddLocationState _validAll(
      bool validName, bool validFullName, bool markeIsNotEmpty) {
    return state.copyWith(
      validAll: validName && validFullName && markeIsNotEmpty,
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

  String _mapGeolectorMessage(StatuesPermission permission) {
    if (permission == StatuesPermission.permissionDenied) {
      return "please get permission for use this service";
    } else if (permission == StatuesPermission.deniedForever) {
      return "Permission has been denied forever please go to application setting and get location permission";
    } else if (permission == StatuesPermission.serverLocationNotEnabeld) {
      return "please turn on location service in your phone for use this servise";
    } else {
      return "";
    }
  }
}
