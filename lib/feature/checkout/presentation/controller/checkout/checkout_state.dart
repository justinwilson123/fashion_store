part of 'checkout_bloc.dart';

enum StatusDefaultLocation {
  isLoading,
  notFind,
  success,
}

enum StatusDefaultCard {
  isLoading,
  notFind,
  success,
}

class CheckoutState extends Equatable {
  final int price;
  final String errorMessage;
  final String successMessage;
  final String successAddOrder;
  final int indexPayment;
  final String namePayment;
  final LocationEntity defaultLocation;
  final CardEntity defaultCard;
  final bool locationFind;
  final bool paymentFind;
  final bool isDefaultCardLoading;
  final bool isDefaultLocationLoading;
  final List<CardEntity> listCard;
  final List<LocationEntity> listLocation;
  final bool isCardsLoading;
  final bool isLocationsLoading;
  final int groupValueCard;
  final int groupValueLocation;
  final int discount;
  final bool validCoupon;
  final bool couponLoading;
  final String couponName;
  final bool addOrderLoading;
  final bool validOrder;
  const CheckoutState({
    this.price = 0,
    this.successAddOrder = "",
    this.errorMessage = "",
    this.successMessage = "",
    this.indexPayment = 0,
    this.namePayment = "card",
    this.defaultLocation = const LocationEntity(
      locationID: 0,
      userID: 0,
      longitude: 0.0,
      latitude: 0.0,
      addressName: "",
      fullAddress: "",
      defultAddress: 0,
    ),
    this.defaultCard = const CardEntity(
        id: 0,
        userID: 0,
        paymentMethod: "",
        cardLast4: "",
        cardBrand: "",
        isDefault: 0),
    this.locationFind = false,
    this.paymentFind = false,
    this.isDefaultCardLoading = true,
    this.isDefaultLocationLoading = true,
    this.listCard = const [],
    this.listLocation = const [],
    this.isCardsLoading = true,
    this.isLocationsLoading = true,
    this.groupValueCard = 0,
    this.groupValueLocation = 0,
    this.discount = 0,
    this.validCoupon = false,
    this.couponLoading = false,
    this.couponName = "",
    this.addOrderLoading = false,
    this.validOrder = false,
  });

  CheckoutState copyWith({
    int? price,
    String? errorMessage,
    String? successMessage,
    String? successAddOrder,
    int? indexPayment,
    String? namePayment,
    LocationEntity? defaultLocation,
    bool? isDefaultCardLoading,
    bool? isDefaultLocationLoading,
    CardEntity? defaultCard,
    bool? locationFind,
    bool? paymentFind,
    List<CardEntity>? listCard,
    List<LocationEntity>? listLocation,
    bool? isCardsLoading,
    int? groupValueCard,
    int? groupValueLocation,
    int? discount,
    bool? isLocationsLoading,
    bool? validCoupon,
    bool? couponLoading,
    String? couponName,
    bool? addOrderLoading,
    bool? validOrder,
  }) {
    return CheckoutState(
      price: price ?? this.price,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      indexPayment: indexPayment ?? this.indexPayment,
      namePayment: namePayment ?? this.namePayment,
      defaultLocation: defaultLocation ?? this.defaultLocation,
      isDefaultCardLoading: isDefaultCardLoading ?? this.isDefaultCardLoading,
      isDefaultLocationLoading:
          isDefaultLocationLoading ?? this.isDefaultLocationLoading,
      defaultCard: defaultCard ?? this.defaultCard,
      locationFind: locationFind ?? this.locationFind,
      paymentFind: paymentFind ?? this.paymentFind,
      listCard: listCard ?? this.listCard,
      listLocation: listLocation ?? this.listLocation,
      isCardsLoading: isCardsLoading ?? this.isCardsLoading,
      groupValueCard: groupValueCard ?? this.groupValueCard,
      groupValueLocation: groupValueLocation ?? this.groupValueLocation,
      isLocationsLoading: isLocationsLoading ?? this.isLocationsLoading,
      discount: discount ?? this.discount,
      validCoupon: validCoupon ?? this.validCoupon,
      couponLoading: couponLoading ?? this.couponLoading,
      couponName: couponName ?? this.couponName,
      addOrderLoading: addOrderLoading ?? this.addOrderLoading,
      successAddOrder: successAddOrder ?? this.successAddOrder,
      validOrder: validOrder ?? this.validOrder,
    );
  }

  @override
  List<Object> get props => [
        price,
        successAddOrder,
        errorMessage,
        successMessage,
        indexPayment,
        errorMessage,
        defaultLocation,
        defaultCard,
        isDefaultCardLoading,
        isDefaultLocationLoading,
        locationFind,
        paymentFind,
        listCard,
        listLocation,
        isCardsLoading,
        isLocationsLoading,
        groupValueCard,
        groupValueLocation,
        discount,
        validCoupon,
        couponLoading,
        couponName,
        addOrderLoading,
        validOrder,
      ];
}

final class CheckoutInitial extends CheckoutState {}
