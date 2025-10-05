part of 'saved_bloc.dart';

class SavedState extends Equatable {
  final List<SavedProductEntity> product;
  final bool hasRechedMax;
  final bool isLoading;
  final String errorMessage;
  final String successMessage;
  final Map savedProduct;

  const SavedState({
    this.product = const [],
    this.hasRechedMax = false,
    this.isLoading = true,
    this.errorMessage = "",
    this.successMessage = "",
    this.savedProduct = const {},
  });

  SavedState copyWith({
    List<SavedProductEntity>? product,
    bool? hasRechedMax,
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
    Map? savedProduct,
  }) {
    return SavedState(
      product: product ?? this.product,
      hasRechedMax: hasRechedMax ?? this.hasRechedMax,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      savedProduct: savedProduct ?? this.savedProduct,
    );
  }

  @override
  List<Object> get props => [
        product,
        hasRechedMax,
        isLoading,
        errorMessage,
        successMessage,
        savedProduct,
      ];
}

final class SavedInitial extends SavedState {}
