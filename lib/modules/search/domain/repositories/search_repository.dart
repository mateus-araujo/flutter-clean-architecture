import 'package:clean_architecture/modules/search/domain/entities/query_params.dart';
import 'package:dartz/dartz.dart';

import 'package:clean_architecture/modules/search/domain/entities/result_search.dart';
import 'package:clean_architecture/modules/search/domain/errors/errors.dart';

abstract class SearchRepository {
  Future<Either<FailureSearch, List<ResultSearch>>> search(String searchText);
  Future<Either<FailureSearch, List<ResultSearch>>> searchWithParams(
      QueryParams params);
}
