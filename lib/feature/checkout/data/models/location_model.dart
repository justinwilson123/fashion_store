import 'package:fashion/feature/checkout/domin/entity/checkout_entities.dart';

class LocationModel extends LocationEntity {
  const LocationModel({
    required super.locationID,
    required super.userID,
    required super.longitude,
    required super.latitude,
    required super.addressName,
    required super.fullAddress,
    required super.defultAddress,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      locationID: json['location_id'],
      userID: json['location_user_id'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      addressName: json['address_name'],
      fullAddress: json['full_address'],
      defultAddress: json['defult_address'],
    );
  }
  // {
  //       "location_id": 1,
  //       "location_user_id": 1,
  //       "longitude": 35.03923,
  //       "latitude": 34.328948,
  //       "address_name": "home",
  //       "full_address": "hfds  akdj a df a",
  //       "defult_address": 1
  //   }

  Map<String, dynamic> toJson() {
    return {
      "userID": userID.toString(),
      "longitude": longitude.toString(),
      "latitude": latitude.toString(),
      "addressName": addressName,
      "fullAddress": fullAddress,
      "isDefault": defultAddress.toString(),
    };
  }
}
