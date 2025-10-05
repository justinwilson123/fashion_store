import 'package:fashion/core/services/crud.dart';
import 'package:fashion/feature/search/data/model/search_model.dart';

import '../../../../core/constant/app_links.dart';
import '../../../../core/error/exception.dart';

abstract class SearchRemoteDataSource {
  Future<List<SearchModel>> getResult(String name);
}

class SearchRemoteDataSourceWithHttp implements SearchRemoteDataSource {
  final Crud crud;
  SearchRemoteDataSourceWithHttp(this.crud);

  @override
  Future<List<SearchModel>> getResult(String name) async {
    final data = {"search": name};
    final response = await crud.postData(AppLinks.search, data);
    if (response['status'] == "success") {
      final listData = response['data'] as List;
      final searchResults = listData
          .map((json) => SearchModel.fromJson(json))
          .toList();
      return searchResults;
    } else if (response['status'] == "failure") {
      throw NoDataException();
    } else {
      throw ServerException();
    }
  }
}
