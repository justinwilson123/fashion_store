part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<CartEntity> cart;
  final bool cartLoading;
  final String errorMessage;
  final String successMessage;
  final int sumAllItemPrice;
  final bool isAddRemoveDeleteLoading;
  const CartState(
      {this.cart = const [],
      this.cartLoading = true,
      this.errorMessage = '',
      this.successMessage = '',
      this.sumAllItemPrice = 0,
      this.isAddRemoveDeleteLoading = false});

  CartState copyWith(
      {List<CartEntity>? cart,
      bool? cartLoading,
      String? errorMessage,
      String? successMessage,
      int? sumAllItemPrice,
      bool? isAddRemoveDeleteLoading}) {
    return CartState(
      cart: cart ?? this.cart,
      cartLoading: cartLoading ?? this.cartLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      sumAllItemPrice: sumAllItemPrice ?? this.sumAllItemPrice,
      isAddRemoveDeleteLoading:
          isAddRemoveDeleteLoading ?? this.isAddRemoveDeleteLoading,
    );
  }

  @override
  List<Object> get props => [
        cart,
        cartLoading,
        errorMessage,
        successMessage,
        sumAllItemPrice,
        isAddRemoveDeleteLoading,
      ];
}

final class CartInitial extends CartState {}
