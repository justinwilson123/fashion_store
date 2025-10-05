part of 'reviews_bloc.dart';

class ReviewsState extends Equatable {
  final List<ReviewsEntity> reviews;
  final Map countGroupRating;
  final bool isReviewsLoading;
  final bool reviesHasReachedMax;
  final String errorMessage;
  const ReviewsState({
    this.reviews = const [],
    this.isReviewsLoading = true,
    this.reviesHasReachedMax = false,
    this.countGroupRating = const {},
    this.errorMessage = "",
  });

  ReviewsState copyWith({
    List<ReviewsEntity>? reviews,
    Map? countGroupRating,
    bool? isReviewsLoading,
    bool? reviesHasReachedMax,
    String? errorMessage,
  }) {
    return ReviewsState(
      reviews: reviews ?? this.reviews,
      countGroupRating: countGroupRating ?? this.countGroupRating,
      isReviewsLoading: isReviewsLoading ?? this.isReviewsLoading,
      reviesHasReachedMax: reviesHasReachedMax ?? this.reviesHasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        reviews,
        countGroupRating,
        isReviewsLoading,
        reviesHasReachedMax,
        errorMessage,
      ];
}

final class ReviewsInitial extends ReviewsState {}
