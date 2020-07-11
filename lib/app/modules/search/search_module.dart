import 'package:ma9filmes/app/modules/search/search_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ma9filmes/app/modules/search/search_page.dart';

class SearchModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => SearchBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => SearchPage();

  static Inject get to => Inject<SearchModule>.of();
}
