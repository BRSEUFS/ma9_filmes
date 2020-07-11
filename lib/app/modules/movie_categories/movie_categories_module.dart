import 'package:ma9filmes/app/modules/movie_categories/movie_categories_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ma9filmes/app/modules/movie_categories/movie_categories_page.dart';

class MovieCategoriesModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => MovieCategoriesBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => MovieCategoriesPage();

  static Inject get to => Inject<MovieCategoriesModule>.of();
}
