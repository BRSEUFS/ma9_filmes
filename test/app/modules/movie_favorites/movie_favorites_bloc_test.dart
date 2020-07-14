import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:ma9filmes/app/modules/movie_favorites/movie_favorites_bloc.dart';
import 'package:ma9filmes/app/modules/movie_favorites/movie_favorites_module.dart';

void main() {
  initModule(MovieFavoritesModule());
  MovieFavoritesBloc bloc;

  // setUp(() {
  //     bloc = MovieFavoritesModule.to.bloc<MovieFavoritesBloc>();
  // });

  // group('MovieFavoritesBloc Test', () {
  //   test("First Test", () {
  //     expect(bloc, isInstanceOf<MovieFavoritesBloc>());
  //   });
  // });
}
