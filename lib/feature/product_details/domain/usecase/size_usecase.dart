import 'package:dartz/dartz.dart';
import 'package:fashion/feature/product_details/domain/entity/details_entities.dart';
import 'package:fashion/feature/product_details/domain/repositories/product_details_repositories.dart';

import '../../../../core/error/failure.dart';

class SizesUsecase {
  final ProductDetailsRepositories productDetails;
  SizesUsecase(this.productDetails);
  Future<Either<Failure, List<SizedEntity>>> call(int productID) async {
    return await productDetails.getSizes(productID);
  }
}
