import 'package:clean_architecture/modules/search/domain/entities/result_search.dart';
import 'package:clean_architecture/modules/search/domain/errors/errors.dart';
import 'package:clean_architecture/modules/search/infra/datasources/search_datasource.dart';
import 'package:clean_architecture/modules/search/infra/models/resul_search_model.dart';
import 'package:clean_architecture/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SearchDatasourceMock extends Mock implements SearchDatasource {}

main() {
  final datasource = SearchDatasourceMock();
  final repository = SearchRepositoryImpl(datasource);

  test('should return a <List<ResultSearch>>', () async {
    when(datasource.getSearch(any))
        .thenAnswer((_) async => <ResultSearchModel>[]);
    final result = await repository.search("searchText");

    expect(result | null, isA<List<ResultSearch>>());
  });

  test('should return a DatasourceError whether datasource fails', () async {
    when(datasource.getSearch(any)).thenThrow(Exception());
    final result = await repository.search("searchText");

    expect(result.fold(id, id), isA<DatasourceError>());
  });
}
