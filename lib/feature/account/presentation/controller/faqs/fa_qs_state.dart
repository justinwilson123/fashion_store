part of 'fa_qs_bloc.dart';

class FaQsState extends Equatable {
  final List<FAQsEntity> fAQs;
  final List<FAQsEntity> searchFAQs;
  final bool isLoading;
  final bool searchLoading;
  final int initIndex;
  final String errorMessage;
  final String topic;
  final String search;
  const FaQsState({
    this.fAQs = const [],
    this.searchFAQs = const [],
    this.initIndex = 0,
    this.isLoading = true,
    this.searchLoading = false,
    this.errorMessage = "",
    this.topic = "",
    this.search = "",
  });
  FaQsState copyWith(
      {List<FAQsEntity>? fAQs,
      List<FAQsEntity>? searchFAQs,
      bool? isLoading,
      bool? searchLoading,
      int? initIndex,
      String? errorMessage,
      String? topic,
      String? search}) {
    return FaQsState(
      fAQs: fAQs ?? this.fAQs,
      searchFAQs: searchFAQs ?? this.searchFAQs,
      initIndex: initIndex ?? this.initIndex,
      isLoading: isLoading ?? this.isLoading,
      searchLoading: searchLoading ?? this.searchLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      topic: topic ?? this.topic,
      search: search ?? this.search,
    );
  }

  @override
  List<Object> get props => [
        fAQs,
        searchFAQs,
        isLoading,
        searchLoading,
        initIndex,
        errorMessage,
        topic,
        search,
      ];
}

final class FaQsInitial extends FaQsState {}
