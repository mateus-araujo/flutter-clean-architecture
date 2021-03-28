import 'dart:convert';

import 'package:clean_architecture/modules/search/domain/errors/errors.dart';
import 'package:clean_architecture/modules/search/external/datasources/github_datasource.dart';
import 'package:clean_architecture/modules/search/infra/models/query_params_model.dart';
import 'package:clean_architecture/modules/search/utils/github_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();

  final datasource = GithubDatasource(dio);

  /** 
   * dio.get(any)
   * datasource.getSearch 
   * */

  test("should return a List<ResultSearchModel>", () {
    when(dio.get(any)).thenAnswer(
        (_) async => Response(data: jsonDecode(githubResult), statusCode: 200));

    final future = datasource.getSearch("searchText");
    expect(future, completes);
  });

  test("should return a DatasourceError whether status code is not 200", () {
    when(dio.get(any))
        .thenAnswer((_) async => Response(data: null, statusCode: 400));

    final future = datasource.getSearch("searchText");
    expect(future, throwsA(isA<DatasourceError>()));
  });

  test("should return a Exception whether has an error on Dio", () {
    when(dio.get(any)).thenThrow(Exception());

    final future = datasource.getSearch("searchText");
    expect(future, throwsA(isA<Exception>()));
  });

  /** 
   * dio.get(any, queryParameters)
   * datasource.getSearchWithParams 
   * */

  test("should return a List<ResultSearchModel> with getSearchWithParams", () {
    when(dio.get(any, queryParameters: QueryParamsModel("searchText").toMap()))
        .thenAnswer((_) async =>
            Response(data: jsonDecode(githubResult), statusCode: 200));

    final future =
        datasource.getSearchWithParams(QueryParamsModel("searchText"));
    expect(future, completes);
  });

  test(
      "should return a DatasourceError whether status code is not 200 with getSearchWithParams",
      () {
    when(dio.get(any, queryParameters: QueryParamsModel("searchText").toMap()))
        .thenAnswer((_) async => Response(data: null, statusCode: 400));

    final future =
        datasource.getSearchWithParams(QueryParamsModel("searchText"));
    expect(future, throwsA(isA<DatasourceError>()));
  });

  test(
      "should return a Exception whether has an error on Dio with getSearchWithParams",
      () {
    when(dio.get(any, queryParameters: QueryParamsModel("searchText").toMap()))
        .thenThrow(Exception());

    final future =
        datasource.getSearchWithParams(QueryParamsModel("searchText"));
    expect(future, throwsA(isA<Exception>()));
  });
}
