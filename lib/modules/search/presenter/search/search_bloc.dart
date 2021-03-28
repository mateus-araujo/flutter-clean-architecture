import 'package:bloc/bloc.dart';
import 'package:clean_architecture/modules/search/domain/entities/query_params.dart';
import 'package:rxdart/rxdart.dart';

import 'package:clean_architecture/modules/search/domain/entities/result_search.dart';
import 'package:clean_architecture/modules/search/domain/usecases/search_with_params.dart';
import 'package:clean_architecture/modules/search/presenter/search/states/events.dart';
import 'package:clean_architecture/modules/search/presenter/search/states/state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  int page = 1;
  String searchText;
  List<ResultSearch> list = [];

  final SearchWithParams usecase;

  SearchBloc(this.usecase) : super(SearchStart());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is GetSearchEvent) {
      yield SearchLoading();
      searchText = event.searchText;
      final result = await usecase(QueryParams(searchText));

      yield result.fold((l) => SearchError(l), (r) {
        final searchSuccess = SearchSuccess(r);
        list = searchSuccess.list;
        page = 1;
        return searchSuccess;
      });
    }

    if (event is IncrementPageEvent) {
      yield SearchLoadingMore(list);
      page++;
      final result = await usecase(QueryParams(searchText, page: page));
      yield result.fold((l) => SearchError(l), (r) {
        final searchSuccess = SearchSuccess([...list, ...r]);
        list = searchSuccess.list;
        return searchSuccess;
      });
    }
  }

  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
      Stream<SearchEvent> events, transitionFn) {
    final nonDebounceStream = events.where((event) => event is! GetSearchEvent);

    final debounceStream = events
        .where((event) => event is GetSearchEvent)
        .debounceTime(Duration(milliseconds: 800));

    return super.transformEvents(
        MergeStream([nonDebounceStream, debounceStream]), transitionFn);
  }
}
