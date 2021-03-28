import 'package:clean_architecture/modules/search/domain/entities/query_params.dart';

class QueryParamsModel extends QueryParams {
  final String searchText;
  final String sort;
  final String order;
  final int perPage;
  final int page;

  QueryParamsModel(this.searchText,
      {this.sort, this.order, this.perPage, this.page})
      : super('');

  Map<String, dynamic> toMap() {
    return {
      'q': searchText,
      'sort': sort,
      'order': order,
      'per_page': perPage,
      'page': page,
    };
  }

  static QueryParamsModel toQueryParamsModel(QueryParams queryParams) {
    return QueryParamsModel(
      queryParams.searchText,
      order: queryParams.order,
      page: queryParams.page,
      perPage: queryParams.perPage,
      sort: queryParams.sort,
    );
  }
}
