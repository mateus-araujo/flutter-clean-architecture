import 'package:clean_architecture/modules/search/infra/models/query_params_model.dart';
import 'package:clean_architecture/modules/search/infra/models/result_search_model.dart';

abstract class SearchDatasource {
  Future<List<ResultSearchModel>> getSearch(String searchText);
  Future<List<ResultSearchModel>> getSearchWithParams(QueryParamsModel params);
}
