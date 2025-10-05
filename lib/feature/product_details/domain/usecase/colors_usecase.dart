import 'package:dartz/dartz.dart';
import 'package:fashion/feature/product_details/domain/repositories/product_details_repositories.dart';

import '../../../../core/error/failure.dart';
import '../entity/details_entities.dart';

class ColorsUsecase {
  final ProductDetailsRepositories productDetails;
  ColorsUsecase(this.productDetails);

  Future<Either<Failure, List<ColorsEntity>>> call(
      int productID, int sizeID) async {
    return await productDetails.getColors(productID, sizeID);
  }
}
