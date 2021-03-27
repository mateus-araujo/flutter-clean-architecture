import 'package:dio/dio.dart';

import 'package:clean_architecture/modules/search/domain/errors/errors.dart';
import 'package:clean_architecture/modules/search/infra/datasources/search_datasource.dart';
import 'package:clean_architecture/modules/search/infra/models/result_search_model.dart';

extension on String {
  normalize() {
    return this.replaceAll(" ", "+");
  }
}

class GithubDatasource implements SearchDatasource {
  final Dio dio;

  GithubDatasource(this.dio);

  @override
  Future<List<ResultSearchModel>> getSearch(String searchText) async {
    final response = await dio
        .get("https://api.github.com/search/users?q=${searchText.normalize()}");

    if (response.statusCode == 200) {
      final List list = (response.data['items'] as List)
          .map((item) => ResultSearchModel.fromMap(item))
          .toList();

      return list;
    } else {
      throw DatasourceError();
    }
  }
}
