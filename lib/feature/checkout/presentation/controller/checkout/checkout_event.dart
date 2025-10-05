part of 'checkout_bloc.dart';

sealed class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class GetDefaultLoctionEvent extends CheckoutEvent {
  const GetDefaultLoctionEvent();
  @override
  List<Object> get props => [];
}

class GetTotalPrice extends CheckoutEvent {
  final int price;
  const GetTotalPrice(this.price);
  @override
  List<Object> get props => [price];
}

class GetDefaultCardEvent extends CheckoutEvent {
  const GetDefaultCardEvent();
  @override
  List<Object> get props => [];
}

class GetAllLocationEvent extends CheckoutEvent {
  const GetAllLocationEvent();
  @override
  List<Object> get props => [];
}

class GetAllCardEvent extends CheckoutEvent {
  const GetAllCardEvent();
  @override
  List<Object> get props => [];
}

class ChangePaymentMethodEvent extends CheckoutEvent {
  final int indexPayment;
  final String namePayment;
  const ChangePaymentMethodEvent(this.indexPayment, this.namePayment);
  @override
  List<Object> get props => [indexPayment, namePayment];
}

class ChangeCardEvent extends CheckoutEvent {
  final int groupValueCard;
  final CardEntity card;
  const ChangeCardEvent(this.card, this.groupValueCard);
  @override
  List<Object> get props => [card, groupValueCard];
}

class ChangeLocationEvent extends CheckoutEvent {
  final int groupValueLocation;
  final LocationEntity location;
  const ChangeLocationEvent(this.groupValueLocation, this.location);
  @override
  List<Object> get props => [groupValueLocation, location];
}

class ValidCouponFieldEvent extends CheckoutEvent {
  final bool isValid;
  final String couponName;
  const ValidCouponFieldEvent(this.isValid, this.couponName);
  @override
  List<Object> get props => [isValid, couponName];
}

class AddCouponEvent extends CheckoutEvent {
  const AddCouponEvent();
  @override
  List<Object> get props => [];
}

class AddOrderEvent extends CheckoutEvent {
  const AddOrderEvent();
  @override
  List<Object> get props => [];
}
