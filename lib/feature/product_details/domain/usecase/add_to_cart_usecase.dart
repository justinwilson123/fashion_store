import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/product_details_repositories.dart';

class AddToCartUsecase {
  final ProductDetailsRepositories productDetails;
  AddToCartUsecase(this.productDetails);
  Future<Either<Failure, Unit>> call({
    required int producID,
    required String price,
    required int userID,
    required String image,
    required String nameEn,
    required String nameAr,
    required int sizeID,
    required int colorID,
  }) async {
    return await productDetails.addToCart(
      producID,
      price,
      userID,
      image,
      nameEn,
      nameAr,
      sizeID,
      colorID,
    );
  }
}
