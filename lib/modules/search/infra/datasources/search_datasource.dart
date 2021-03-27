import 'package:clean_architecture/modules/search/infra/models/resul_search_model.dart';

abstract class SearchDatasource {
  Future<List<ResultSearchModel>> getSearch(String searchText);
}
