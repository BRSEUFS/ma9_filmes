import 'package:ma9filmes/app/modules/movie_detail/movie_detail_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ma9filmes/app/modules/movie_detail/movie_detail_page.dart';
import 'package:ma9filmes/shared/models/filme_model.dart';

class MovieDetailModule extends ModuleWidget {

  final FilmeModel filme;

  MovieDetailModule(this.filme);

  @override
  List<Bloc> get blocs => [
        Bloc((i) => MovieDetailBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => MovieDetailPage(filme: filme,);

  static Inject get to => Inject<MovieDetailModule>.of();
}
