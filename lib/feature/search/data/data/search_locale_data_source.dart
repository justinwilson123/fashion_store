import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fashion/feature/search/data/model/search_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';

abstract class SearchLocaleDataSource {
  Future<List<SearchModel>> getCachedResult();
  Future<Unit> cachedResult(List<SearchModel> productModel);
}

const CASCHED_RESULT = "CASCHED_RESULT";

class SearchLocaleDataSourceSharedPref implements SearchLocaleDataSource {
  final SharedPreferences sharedPreferences;
  SearchLocaleDataSourceSharedPref(this.sharedPreferences);
  @override
  Future<Unit> cachedResult(List<SearchModel> searchModels) {
    List productModelToJson = searchModels
        .map<Map<String, dynamic>>((searchModel) => searchModel.toJson())
        .toList();
    sharedPreferences.setString(CASCHED_RESULT, jsonEncode(productModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<SearchModel>> getCachedResult() {
    final jsonString = sharedPreferences.getString(CASCHED_RESULT);
    if (jsonString != null) {
      List decodeJson = jsonDecode(jsonString);
      if (decodeJson.isNotEmpty) {
        List<SearchModel> jsonToSearchModel = decodeJson
            .map<SearchModel>(
              (jsonSearchModul) => SearchModel.fromJson(jsonSearchModul),
            )
            .toList();
        return Future.value(jsonToSearchModel);
      } else {
        throw EmptyCachException();
      }
    } else {
      throw EmptyCachException();
    }
  }
}
