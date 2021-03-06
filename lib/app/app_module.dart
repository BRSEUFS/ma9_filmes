import 'package:ma9filmes/app/app_repository.dart';
import 'package:ma9filmes/app/app_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ma9filmes/app/app_widget.dart';
import 'package:ma9filmes/shared/custom_dio/CustomDio.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => AppBloc(AppModule.to.getDependency<AppRepository>())),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency(
            (i) => AppRepository(AppModule.to.getDependency<CustomDio>())),
        Dependency((i) => CustomDio())
      ];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
