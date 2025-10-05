import 'package:dartz/dartz.dart';
import 'package:fashion/core/constant/app_links.dart';
import 'package:fashion/core/error/exception.dart';
import 'package:fashion/core/services/crud.dart';
import 'package:fashion/feature/account/data/models/my_details_model.dart';

abstract class MyDetailsRemoteDataSource {
  Future<Unit> updateMyDetails(MyDetailsModel details);
}

class MyDetailsRemoteDataWithHttp implements MyDetailsRemoteDataSource {
  final Crud crud;
  MyDetailsRemoteDataWithHttp(this.crud);
  @override
  Future<Unit> updateMyDetails(MyDetailsModel details) async {
    final data = details.toJson();
    final response = await crud.postData(AppLinks.upDateMyDetials, data);
    if (response['status'] == "success") {
      return Future.value(unit);
    } else if (response['status'] == "failure") {
      throw NoDataException();
    } else {
      throw ServerException();
    }
  }
}
