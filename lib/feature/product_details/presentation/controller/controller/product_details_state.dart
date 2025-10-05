part of 'product_details_bloc.dart';

class ProductDetailsState extends Equatable {
  final List<SizedEntity> sizes;
  final List<ColorsEntity> colors;
  final String successMessage;
  final String errorMessage;
  final bool sizeIsLoading;
  final bool colorIsLoading;
  final int selectSized;
  final int selectColor;
  final int sizeID;
  final int colorID;
  final bool isSelectColor;
  final bool isSelectSize;
  final bool cartLoading;
  const ProductDetailsState({
    this.sizes = const [],
    this.colors = const [],
    this.successMessage = "",
    this.errorMessage = "",
    this.sizeIsLoading = false,
    this.selectSized = 1000,
    this.selectColor = 1000,
    this.sizeID = 0,
    this.colorID = 0,
    this.isSelectSize = false,
    this.isSelectColor = false,
    this.colorIsLoading = false,
    this.cartLoading = false,
  });

  ProductDetailsState copyWith({
    List<SizedEntity>? sizes,
    List<ColorsEntity>? colors,
    String? successMessage,
    String? errorMessage,
    bool? sizeIsLoading,
    bool? colorIsLoading,
    int? selectColor,
    int? selectSized,
    int? sizeID,
    int? colorID,
    bool? isSelectSize,
    bool? isSelectColor,
    bool? cartLoading,
  }) {
    return ProductDetailsState(
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
      successMessage: successMessage ?? this.successMessage,
      errorMessage: errorMessage ?? this.errorMessage,
      sizeIsLoading: sizeIsLoading ?? this.sizeIsLoading,
      colorIsLoading: colorIsLoading ?? this.colorIsLoading,
      selectSized: selectSized ?? this.selectSized,
      selectColor: selectColor ?? this.selectColor,
      sizeID: sizeID ?? this.sizeID,
      colorID: colorID ?? this.colorID,
      isSelectSize: isSelectSize ?? this.isSelectSize,
      isSelectColor: isSelectColor ?? this.isSelectColor,
      cartLoading: cartLoading ?? this.cartLoading,
    );
  }

  @override
  List<Object> get props => [
        sizes,
        colors,
        successMessage,
        errorMessage,
        sizeIsLoading,
        colorIsLoading,
        selectColor,
        isSelectColor,
        isSelectSize,
        sizeID,
        colorID,
        cartLoading,
      ];
}

final class ProductDetailsInitial extends ProductDetailsState {}
