part of 'add_card_bloc.dart';

sealed class AddCardEvent extends Equatable {
  const AddCardEvent();

  @override
  List<Object> get props => [];
}

class AddNewCardEvent extends AddCardEvent {
  final CardEntity card;
  const AddNewCardEvent(this.card);
  @override
  List<Object> get props => [card];
}

class ValidCardNumberEvent extends AddCardEvent {
  final bool isValidCardNumber;
  const ValidCardNumberEvent(this.isValidCardNumber);
  @override
  List<Object> get props => [isValidCardNumber];
}

class ValidCardBrandEvent extends AddCardEvent {
  final bool isValidCarBrand;
  const ValidCardBrandEvent(this.isValidCarBrand);
  @override
  List<Object> get props => [isValidCarBrand];
}

class ValidPaymentMethodEvent extends AddCardEvent {
  final bool isValidPaymentMethod;
  const ValidPaymentMethodEvent(this.isValidPaymentMethod);
  @override
  List<Object> get props => [isValidPaymentMethod];
}

class DefaultCardEvent extends AddCardEvent {
  final bool isDefault;
  const DefaultCardEvent(this.isDefault);
  @override
  List<Object> get props => [isDefault];
}
