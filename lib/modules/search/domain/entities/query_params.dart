class QueryParams {
  final String searchText;
  final String sort;
  final String order;
  final int perPage;
  final int page;

  QueryParams(this.searchText,
      {this.sort, this.order, this.perPage, this.page});
}
