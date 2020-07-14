import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ma9filmes/app/modules/movie_favorites/movie_favorites_page.dart';

class MovieFavoritesModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => MovieFavoritesPage();

  static Inject get to => Inject<MovieFavoritesModule>.of();
}
