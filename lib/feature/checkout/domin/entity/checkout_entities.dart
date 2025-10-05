import 'package:equatable/equatable.dart';

class CardEntity extends Equatable {
  final int id;
  final int userID;
  final String paymentMethod;
  final String cardLast4;
  final String cardBrand;
  final int isDefault;

  const CardEntity({
    required this.id,
    required this.userID,
    required this.paymentMethod,
    required this.cardLast4,
    required this.cardBrand,
    required this.isDefault,
  });

  @override
  List<Object?> get props => [
        id,
        userID,
        paymentMethod,
        cardLast4,
        cardBrand,
        isDefault,
      ];
}

class LocationEntity extends Equatable {
  final int locationID;
  final int userID;
  final double longitude;
  final double latitude;
  final String addressName;
  final String fullAddress;
  final int defultAddress;

  const LocationEntity({
    required this.locationID,
    required this.userID,
    required this.longitude,
    required this.latitude,
    required this.addressName,
    required this.fullAddress,
    required this.defultAddress,
  });
  @override
  List<Object?> get props => [
        locationID,
        userID,
        longitude,
        latitude,
        addressName,
        fullAddress,
        defultAddress,
      ];
}

// {
//         "location_id": 1,
//         "location_user_id": 1,
//         "longitude": 35.03923,
//         "latitude": 34.328948,
//         "address_name": "home",
//         "full_address": "hfds  akdj a df a",
//         "defult_address": 1
//     }

// {
//         "id": 1,
//         "card_user_id": 1,
//         "payment_method_id": "pm_123abc",
//         "card_last4": "4654",
//         "card_brand": "visa",
//         "is_default": 1
//     }