import 'package:clean_architecture/modules/search/domain/entities/result_search.dart';
import 'package:clean_architecture/modules/search/domain/errors/errors.dart';
import 'package:clean_architecture/modules/search/domain/repositories/search_repository.dart';
import 'package:clean_architecture/modules/search/domain/usecases/search_by_text.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SearchReposistoryMock extends Mock implements SearchRepository {}

main() {
  final repository = SearchReposistoryMock();
  final usecase = SearchByTextImpl(repository);

  test('should returns a List<ResultSearch>', () async {
    when(repository.search(any))
        .thenAnswer((_) async => Right(<ResultSearch>[]));

    final result = await usecase("searchText");
    expect(result | null, isA<List<ResultSearch>>());
  });

  test('should returns an InvalidTextError whether the text is invalid',
      () async {
    when(repository.search(any))
        .thenAnswer((_) async => Right(<ResultSearch>[]));
    var result = await usecase(null);

    expect(result.fold(id, id), isA<InvalidTextError>());

    result = await usecase("");
    expect(result.fold(id, id), isA<InvalidTextError>());
  });
}
