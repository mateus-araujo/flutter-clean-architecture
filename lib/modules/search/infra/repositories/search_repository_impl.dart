import 'package:clean_architecture/modules/search/domain/entities/query_params.dart';
import 'package:clean_architecture/modules/search/infra/models/query_params_model.dart';
import 'package:dartz/dartz.dart';

import 'package:clean_architecture/modules/search/domain/entities/result_search.dart';
import 'package:clean_architecture/modules/search/domain/errors/errors.dart';
import 'package:clean_architecture/modules/search/domain/repositories/search_repository.dart';
import 'package:clean_architecture/modules/search/infra/datasources/search_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDatasource datasource;

  SearchRepositoryImpl(this.datasource);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> search(
      String searchText) async {
    try {
      final result = await datasource.getSearch(searchText);

      return Right(result);
    } on DatasourceError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DatasourceError());
    }
  }

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> searchWithParams(
      QueryParams params) async {
    try {
      final result = await datasource
          .getSearchWithParams(QueryParamsModel.toQueryParamsModel(params));

      return Right(result);
    } on DatasourceError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DatasourceError());
    }
  }
}
