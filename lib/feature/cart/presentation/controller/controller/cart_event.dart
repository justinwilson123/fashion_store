part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class GetCartEvent extends CartEvent {
  const GetCartEvent();
  @override
  List<Object> get props => [];
}

class AddOnePieceEvent extends CartEvent {
  final int productID;
  final int colorID;
  final int sizedID;
  final int price;
  final String image;
  final String nameEn;
  final String nameAr;
  const AddOnePieceEvent(
    this.productID,
    this.sizedID,
    this.colorID,
    this.image,
    this.nameAr,
    this.nameEn,
    this.price,
  );
  @override
  List<Object> get props =>
      [productID, sizedID, colorID, image, nameAr, nameEn, price];
}

class RemoveOnePieceEvent extends CartEvent {
  final int productID;
  final int colorID;
  final int sizedID;
  const RemoveOnePieceEvent(this.productID, this.sizedID, this.colorID);
  @override
  List<Object> get props => [productID, sizedID, colorID];
}

class DeleteAllPieceEvent extends CartEvent {
  final int productID;
  final int colorID;
  final int sizedID;
  const DeleteAllPieceEvent(this.productID, this.sizedID, this.colorID);
  @override
  List<Object> get props => [productID, sizedID, colorID];
}
