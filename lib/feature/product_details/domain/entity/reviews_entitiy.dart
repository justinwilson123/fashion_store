import 'package:equatable/equatable.dart';

class ReviewsEntity extends Equatable {
  final String userName;
  final int rating;
  final String comment;
  final DateTime time;
  const ReviewsEntity({
    required this.userName,
    required this.rating,
    required this.comment,
    required this.time,
  });
  @override
  List<Object?> get props => [
        userName,
        rating,
        comment,
        time,
      ];
}

class CountGroupByRatingEntity extends Equatable {
  final int rating;
  final int numberRating;
  const CountGroupByRatingEntity({
    required this.rating,
    required this.numberRating,
  });
  @override
  List<Object?> get props => [rating, numberRating];
}
// {
//             "rating": 1,
//             "number_rating": 2
//         }

        // {
        //     "user_full_name": "alaa",
        //     "rating_id": 3,
        //     "rating_user_id": 1,
        //     "rating_product_id": 26,
        //     "rating_comment": "good product",
        //     "rating": 5,
        //     "rating_date": "2025-07-08 14:31:50"
        // }