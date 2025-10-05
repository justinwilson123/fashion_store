import 'package:fashion/core/constant/app_links.dart';
import 'package:fashion/core/error/exception.dart';
import 'package:fashion/core/services/crud.dart';
import 'package:fashion/feature/account/data/models/f_a_qs_model.dart';

abstract class FAQsRemoteDataSources {
  Future<List<FAQsModel>> getGeneralFAQs();
  Future<List<FAQsModel>> getTopicFAQs(String topic);
  Future<List<FAQsModel>> getSearchFAQs(String search);
}

class FAQsRemoteDataWithHttp implements FAQsRemoteDataSources {
  final Crud crud;
  FAQsRemoteDataWithHttp(this.crud);
  @override
  Future<List<FAQsModel>> getGeneralFAQs() async {
    final Map<String, String> data = {};
    return await _getListFAQsModel(AppLinks.generalFAQsLink, data);
  }

  @override
  Future<List<FAQsModel>> getSearchFAQs(String search) async {
    final Map<String, String> data = {"search": search};
    return await _getListFAQsModel(AppLinks.searchFAQsLink, data);
  }

  @override
  Future<List<FAQsModel>> getTopicFAQs(String topic) async {
    final Map<String, String> data = {"topic": topic};
    return await _getListFAQsModel(AppLinks.topicFAQsLink, data);
  }

  Future<List<FAQsModel>> _getListFAQsModel(
    String link,
    Map<String, String> data,
  ) async {
    final response = await crud.postData(link, data);
    if (response['status'] == "success") {
      List responseList = response['data'] as List;
      List<FAQsModel> listFAQSModel =
          responseList.map((json) => FAQsModel.fromJson(json)).toList();
      return listFAQSModel;
    } else if (response['status'] == "failure") {
      throw NoDataException();
    } else {
      throw ServerException();
    }
  }
}
