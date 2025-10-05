import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/product_details/domain/usecase/count_group_rating_usecase.dart';
import 'package:fashion/feature/product_details/domain/usecase/reviews_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constant/strings/failure_message.dart';
import '../../../domain/entity/reviews_entitiy.dart';

part 'reviews_event.dart';
part 'reviews_state.dart';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  int page = 0;
  final ReviewsUsecase reviewsUsecase;
  final CountGroupRatingUsecase countGroupRating;

  ReviewsBloc(this.reviewsUsecase, this.countGroupRating)
      : super(ReviewsInitial()) {
    on<GetReviewsEvent>((event, emit) async {
      if (state.reviesHasReachedMax) return;
      emit(state.copyWith(isReviewsLoading: true, errorMessage: ""));
      page += 1;
      final either = await reviewsUsecase.call(event.productID, page);
      either.fold(
        (failure) {
          print(failure);
          if (failure is NoDataFailure) {
            emit(state.copyWith(
              isReviewsLoading: false,
              reviesHasReachedMax: true,
            ));
          } else {
            emit(state.copyWith(
              errorMessage: _mapFailureToMessage(failure),
              isReviewsLoading: false,
            ));
          }
        },
        (reviews) {
          print(reviews);
          reviews.length >= 10
              ? emit(state.copyWith(
                  reviews: List.of(state.reviews)..addAll(reviews),
                  isReviewsLoading: false,
                ))
              : emit(state.copyWith(
                  reviews: List.of(state.reviews)..addAll(reviews),
                  isReviewsLoading: false,
                  reviesHasReachedMax: true,
                ));
        },
      );
    }, transformer: droppable());
    on<ReviewsEvent>((event, emit) async {
      if (event is GetCountGroupByRatingEvent) {
        final either = await countGroupRating.call(event.productID);
        either.fold(
          (failure) {
            print(failure);
            if (failure is NoDataFailure) {
              emit(state.copyWith(
                  isReviewsLoading: false, reviesHasReachedMax: true));
            } else {
              emit(state.copyWith(errorMessage: _mapFailureToMessage(failure)));
            }
          },
          (countGroupByRating) {
            print(countGroupByRating);
            emit(state.copyWith(
                countGroupRating: countGroupByRating.fold({}, (prev, element) {
              prev!.addAll({element.rating: element.numberRating});
              return prev;
            })));
          },
        );
      }
    });
  }
  String _mapFailureToMessage(Failure failure) {
    if (failure == ServerFailure()) {
      return SERVER_FAILURE_MESSAGE;
    } else if (failure == OffLineFailure()) {
      return OFFLINE_FAILURE_MESSAGE;
    } else {
      return "UnExpected Error , please try again later";
    }
  }
}
