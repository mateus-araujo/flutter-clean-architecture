import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:clean_architecture/app/app_widget.dart';
import 'package:clean_architecture/modules/search/domain/usecases/search_with_params.dart';
import 'package:clean_architecture/modules/search/external/datasources/github_datasource.dart';
import 'package:clean_architecture/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:clean_architecture/modules/search/presenter/search/search_bloc.dart';
import 'package:clean_architecture/modules/search/presenter/search/search_page.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind((i) => GithubDatasource(i())),
        Bind((i) => SearchRepositoryImpl(i())),
        Bind((i) => SearchWithParamsImpl(i())),
        Bind((i) => SearchBloc(i())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, __) => SearchPage()),
      ];

  @override
  Widget get bootstrap => AppWidget();
}
