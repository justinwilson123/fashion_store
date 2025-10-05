part of 'product_details_bloc.dart';

sealed class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetSizesProductEvent extends ProductDetailsEvent {
  final int productID;
  const GetSizesProductEvent(this.productID);
  @override
  List<Object> get props => [productID];
}

class GetColorsProductEvent extends ProductDetailsEvent {
  final int indexSelected;
  final int productID;
  final int sizeID;
  const GetColorsProductEvent(this.indexSelected, this.productID, this.sizeID);
  @override
  List<Object> get props => [productID, sizeID];
}

class ChooseColorProductEvent extends ProductDetailsEvent {
  final int colorID;
  final int indexColorChoose;
  const ChooseColorProductEvent(this.colorID, this.indexColorChoose);
  @override
  List<Object> get props => [colorID, indexColorChoose];
}

class AddToCartEvent extends ProductDetailsEvent {
  final int producID;
  final String price;
  final String image;
  final String nameEn;
  final String nameAr;
  final int sizeID;
  final int colorID;

  const AddToCartEvent({
    required this.producID,
    required this.price,
    required this.image,
    required this.nameEn,
    required this.nameAr,
    required this.sizeID,
    required this.colorID,
  });
  @override
  List<Object> get props => [
        producID,
        price,
        image,
        nameEn,
        nameAr,
        sizeID,
        colorID,
      ];
}
