part of 'home_bloc_bloc.dart';

class HomeBlocState extends Equatable {
  final bool isCategoriesLoading;
  final bool isAllProductLoading;
  final bool isProductLoading;
  final int categoryID;
  final String successSaveRmoveToSaved;
  final String errorSaveRmoveToSaved;
  final List<CategoryEntiti> categories;
  final List<ProductEntity> allProduct;
  final bool hasReachedMax;
  final bool hasReachedMax1;
  final int initiIndex;
  final String errorMessage;
  final List<ProductEntity> product;
  final int initiIndexFilter;
  final int startePrice;
  final int endPrice;
  final double rangeValueStart;
  final double rangeValueEnd;
  final bool isAllProductFilter;
  final bool isProductFilter;
  final Map savedProduct;
  final bool showHide;
  const HomeBlocState({
    this.isCategoriesLoading = false,
    this.isAllProductLoading = true,
    this.isProductLoading = false,
    this.categoryID = 0,
    this.successSaveRmoveToSaved = "",
    this.errorSaveRmoveToSaved = "",
    this.errorMessage = "",
    this.categories = const [],
    this.allProduct = const [],
    this.hasReachedMax = false,
    this.hasReachedMax1 = false,
    this.initiIndex = 0,
    this.product = const [],
    this.initiIndexFilter = 0,
    this.rangeValueStart = 0.0,
    this.rangeValueEnd = 0.0,
    this.startePrice = 0,
    this.endPrice = 1900,
    this.isAllProductFilter = false,
    this.isProductFilter = false,
    this.savedProduct = const {},
    this.showHide = true,
  });

  HomeBlocState copyWith({
    bool? isCategoriesLoading,
    bool? isAllProductLoading,
    bool? isProductLoading,
    int? categoryID,
    String? successSaveRmoveToSaved,
    String? errorSaveRmoveToSaved,
    String? errorMessage,
    List<CategoryEntiti>? categories,
    List<ProductEntity>? allProduct,
    bool? hasReachedMax,
    bool? hasReachedMax1,
    int? initiIndex,
    List<ProductEntity>? product,
    RangeValues? currentRangeValues,
    double? rangeValueStart,
    double? rangeValueEnd,
    int? startePrice,
    int? endPrice,
    int? initiIndexFilter,
    bool? isAllProductFilter,
    bool? isProductFilter,
    Map? savedProduct,
    bool? showHide,
  }) {
    return HomeBlocState(
      isCategoriesLoading: isCategoriesLoading ?? this.isCategoriesLoading,
      isAllProductLoading: isAllProductLoading ?? this.isAllProductLoading,
      isProductLoading: isProductLoading ?? this.isProductLoading,
      successSaveRmoveToSaved:
          successSaveRmoveToSaved ?? this.successSaveRmoveToSaved,
      errorSaveRmoveToSaved:
          errorSaveRmoveToSaved ?? this.errorSaveRmoveToSaved,
      categories: categories ?? this.categories,
      allProduct: allProduct ?? this.allProduct,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      initiIndex: initiIndex ?? this.initiIndex,
      product: product ?? this.product,
      hasReachedMax1: hasReachedMax1 ?? this.hasReachedMax1,
      categoryID: categoryID ?? this.categoryID,
      errorMessage: errorMessage ?? this.errorMessage,
      rangeValueStart: rangeValueStart ?? this.rangeValueStart,
      rangeValueEnd: rangeValueEnd ?? this.rangeValueEnd,
      startePrice: startePrice ?? this.startePrice,
      endPrice: endPrice ?? this.endPrice,
      initiIndexFilter: initiIndexFilter ?? this.initiIndexFilter,
      isAllProductFilter: isAllProductFilter ?? this.isAllProductFilter,
      isProductFilter: isProductFilter ?? this.isProductFilter,
      savedProduct: savedProduct ?? this.savedProduct,
      showHide: showHide ?? this.showHide,
    );
  }

  @override
  List<Object> get props => [
    isCategoriesLoading,
    isAllProductLoading,
    isProductLoading,
    successSaveRmoveToSaved,
    errorSaveRmoveToSaved,
    categories,
    categoryID,
    allProduct,
    hasReachedMax,
    hasReachedMax1,
    initiIndex,
    product,
    errorMessage,
    rangeValueStart,
    rangeValueEnd,
    startePrice,
    endPrice,
    initiIndexFilter,
    isAllProductFilter,
    isProductFilter,
    savedProduct,
    showHide,
  ];
}

final class HomeInitial extends HomeBlocState {}
