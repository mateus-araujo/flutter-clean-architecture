import 'package:clean_architecture/modules/search/domain/entities/result_search.dart';
import 'package:clean_architecture/modules/search/domain/errors/errors.dart';
import 'package:clean_architecture/modules/search/domain/usecases/search_with_params.dart';
import 'package:clean_architecture/modules/search/presenter/search/search_bloc.dart';
import 'package:clean_architecture/modules/search/presenter/search/states/events.dart';
import 'package:clean_architecture/modules/search/presenter/search/states/state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SearchByTextMock extends Mock implements SearchWithParams {}

main() {
  final usecase = SearchByTextMock();
  final bloc = SearchBloc(usecase);

  test("should return the states on correct order", () {
    when(usecase.call(any)).thenAnswer((_) async => Right(<ResultSearch>[]));

    expect(
        bloc.mapEventToState(GetSearchEvent("searchText")),
        emitsInOrder([
          isA<SearchLoading>(),
          isA<SearchSuccess>(),
        ]));
  });

  test("should return the states on correct order on IncrementPageEvent", () {
    when(usecase.call(any)).thenAnswer((_) async => Right(<ResultSearch>[]));

    expect(
        bloc.mapEventToState(IncrementPageEvent()),
        emitsInOrder([
          isA<SearchLoadingMore>(),
          isA<SearchSuccess>(),
        ]));
  });

  test("should return an InvalidTextError", () {
    when(usecase.call(any)).thenAnswer((_) async => Left(InvalidTextError()));

    expect(
        bloc.mapEventToState(GetSearchEvent("searchText")),
        emitsInOrder([
          isA<SearchLoading>(),
          isA<SearchError>(),
        ]));
  });
}
