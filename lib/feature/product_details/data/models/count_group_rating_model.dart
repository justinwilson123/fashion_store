import 'package:fashion/feature/product_details/domain/entity/reviews_entitiy.dart';

class CountGroupRatingModel extends CountGroupByRatingEntity {
  const CountGroupRatingModel({
    required super.rating,
    required super.numberRating,
  });

  factory CountGroupRatingModel.fromJson(Map<String, dynamic> json) {
    return CountGroupRatingModel(
      rating: json['rating'],
      numberRating: json['number_rating'],
    );
  }
}
//  {
//             "rating": 1,
//             "number_rating": 2
//         },