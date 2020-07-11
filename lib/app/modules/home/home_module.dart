import 'package:ma9filmes/app/app_module.dart';
import 'package:ma9filmes/app/modules/home/repositories/filme_repository.dart';
import 'package:ma9filmes/app/modules/home/home_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ma9filmes/app/modules/home/home_page.dart';
import 'package:ma9filmes/shared/custom_dio/CustomDio.dart';

class HomeModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => HomeBloc(HomeModule.to.getDependency<FilmeRepository>())),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency(
            (i) => FilmeRepository(AppModule.to.getDependency<CustomDio>()))
      ];

  @override
  Widget get view => HomePage();

  static Inject get to => Inject<HomeModule>.of();
}
