import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/account/domain/entities/my_details_entity.dart';
import 'package:fashion/feature/account/domain/repositories/my_details_repositiories.dart';

class UpDateMyDetailsUsecase {
  final MyDetailsRepositiories myDetails;
  UpDateMyDetailsUsecase(this.myDetails);
  Future<Either<Failure, Unit>> call(MyDetailsEntity details) async {
    return await myDetails.upDateDetails(details);
  }
}
