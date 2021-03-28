import 'package:clean_architecture/modules/search/domain/entities/result_search.dart';
import 'package:clean_architecture/modules/search/domain/errors/errors.dart';

abstract class SearchState {}

class SearchSuccess implements SearchState {
  final List<ResultSearch> list;

  SearchSuccess(this.list);
}

class SearchStart implements SearchState {}

class SearchLoading implements SearchState {}

class SearchLoadingMore implements SearchState {
  final List<ResultSearch> list;

  SearchLoadingMore(this.list);
}

class SearchError implements SearchState {
  final FailureSearch error;

  SearchError(this.error);
}
