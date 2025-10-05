part of 'reviews_bloc.dart';

sealed class ReviewsEvent extends Equatable {
  const ReviewsEvent();

  @override
  List<Object> get props => [];
}

class GetCountGroupByRatingEvent extends ReviewsEvent {
  final int productID;
  const GetCountGroupByRatingEvent(this.productID);
  @override
  List<Object> get props => [productID];
}

class GetReviewsEvent extends ReviewsEvent {
  final int productID;
  const GetReviewsEvent(this.productID);
  @override
  List<Object> get props => [productID];
}
