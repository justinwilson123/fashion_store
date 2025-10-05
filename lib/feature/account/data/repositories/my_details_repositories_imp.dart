import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/exception.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/core/services/network_info.dart';
import 'package:fashion/feature/account/data/data/my_details_remote_data_source.dart';
import 'package:fashion/feature/account/data/models/my_details_model.dart';
import 'package:fashion/feature/account/domain/entities/my_details_entity.dart';
import 'package:fashion/feature/account/domain/repositories/my_details_repositiories.dart';

class MyDetailsRepositoriesImp implements MyDetailsRepositiories {
  final MyDetailsRemoteDataSource myDetails;
  final NetworkInfo networkInfo;
  MyDetailsRepositoriesImp(this.myDetails, this.networkInfo);
  @override
  Future<Either<Failure, Unit>> upDateDetails(MyDetailsEntity details) async {
    final MyDetailsModel myDetailsModel = MyDetailsModel(
      userID: details.userID,
      fullName: details.fullName,
      email: details.email,
      brith: details.brith,
      gender: details.gender,
      phone: details.phone,
    );
    if (await networkInfo.isConnected) {
      try {
        await myDetails.updateMyDetails(myDetailsModel);
        return const Right(unit);
      } on NoDataException {
        return Left(NoDataFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
