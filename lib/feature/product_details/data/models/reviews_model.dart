import 'package:fashion/feature/product_details/domain/entity/reviews_entitiy.dart';

class ReviewsModel extends ReviewsEntity {
  const ReviewsModel({
    required super.userName,
    required super.rating,
    required super.comment,
    required super.time,
  });

  factory ReviewsModel.fromJson(Map<String, dynamic> json) {
    return ReviewsModel(
      userName: json['user_full_name'],
      rating: json['rating'],
      comment: json['rating_comment'],
      time: DateTime.parse(json['rating_date']),
    );
  }
}

// {
//             "user_full_name": "alaa",
//             "rating_comment": "good product",
//             "rating": 5,
//             "rating_date": "2025-07-08 14:31:50"
//         }