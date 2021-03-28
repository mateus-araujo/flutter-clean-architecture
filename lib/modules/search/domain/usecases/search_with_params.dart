import 'package:clean_architecture/modules/search/domain/entities/query_params.dart';
import 'package:dartz/dartz.dart';

import 'package:clean_architecture/modules/search/domain/entities/result_search.dart';
import 'package:clean_architecture/modules/search/domain/errors/errors.dart';
import 'package:clean_architecture/modules/search/domain/repositories/search_repository.dart';

abstract class SearchWithParams {
  Future<Either<FailureSearch, List<ResultSearch>>> call(QueryParams params);
}

class SearchWithParamsImpl implements SearchWithParams {
  final SearchRepository repository;

  SearchWithParamsImpl(this.repository);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> call(
      QueryParams params) async {
    if (params == null ||
        params.searchText == null ||
        params.searchText.isEmpty) {
      return Left(InvalidTextError());
    }

    return repository.searchWithParams(params);
  }
}
