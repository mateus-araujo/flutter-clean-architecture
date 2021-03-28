import 'package:clean_architecture/modules/search/domain/entities/result_search.dart';
import 'package:clean_architecture/modules/search/domain/errors/errors.dart';
import 'package:clean_architecture/modules/search/domain/repositories/search_repository.dart';
import 'package:clean_architecture/modules/search/domain/usecases/search_with_params.dart';
import 'package:clean_architecture/modules/search/infra/models/query_params_model.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SearchReposistoryMock extends Mock implements SearchRepository {}

main() {
  final repository = SearchReposistoryMock();
  final usecase = SearchWithParamsImpl(repository);

  test('should returns a List<ResultSearch>', () async {
    when(repository.searchWithParams(any))
        .thenAnswer((_) async => Right(<ResultSearch>[]));

    final result = await usecase(QueryParamsModel('searchText'));
    expect(result | null, isA<List<ResultSearch>>());
  });

  test('should returns an InvalidTextError whether the text is invalid',
      () async {
    when(repository.searchWithParams(any))
        .thenAnswer((_) async => Right(<ResultSearch>[]));
    var result = await usecase(null);

    expect(result.fold(id, id), isA<InvalidTextError>());

    result = await usecase(QueryParamsModel(""));
    expect(result.fold(id, id), isA<InvalidTextError>());
  });
}
