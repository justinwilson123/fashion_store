part of 'search_bloc.dart';

class SearchState extends Equatable {
  final List<SearchEntity> fromCached;
  final List<SearchEntity> fromNetwork;
  final bool isLoading;
  final String errorMessage;
  final String nameProduct;
  const SearchState({
    this.fromCached = const [],
    this.fromNetwork = const [],
    this.isLoading = false,
    this.errorMessage = "",
    this.nameProduct = "",
  });

  SearchState copyWith({
    List<SearchEntity>? fromCached,
    List<SearchEntity>? fromNetwork,
    String? errorMessage,
    bool? isLoading,
    String? nameProduct,
  }) {
    return SearchState(
      fromCached: fromCached ?? this.fromCached,
      fromNetwork: fromNetwork ?? this.fromNetwork,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      nameProduct: nameProduct ?? this.nameProduct,
    );
  }

  @override
  List<Object> get props => [
    fromCached,
    fromNetwork,
    errorMessage,
    nameProduct,
  ];
}

final class SearchInitial extends SearchState {}
