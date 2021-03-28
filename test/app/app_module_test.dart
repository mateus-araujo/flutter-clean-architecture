import 'dart:convert';

import 'package:clean_architecture/app/app_module.dart';
import 'package:clean_architecture/modules/search/domain/entities/query_params.dart';
import 'package:clean_architecture/modules/search/domain/entities/result_search.dart';
import 'package:clean_architecture/modules/search/domain/usecases/search_with_params.dart';
import 'package:clean_architecture/modules/search/utils/github_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();

  initModule(AppModule(), changeBinds: [
    Bind<Dio>((i) => dio),
  ]);

  test('should return a usecase without error', () async {
    final usecase = Modular.get<SearchWithParams>();
    expect(usecase, isA<SearchWithParamsImpl>());
  });

  test('should return a List<ResultSearch>', () async {
    when(dio.get(any)).thenAnswer(
        (_) async => Response(data: jsonDecode(githubResult), statusCode: 200));

    final usecase = Modular.get<SearchWithParams>();
    final result = await usecase(QueryParams("searchText"));

    expect(result | null, isA<List<ResultSearch>>());
  });
}
