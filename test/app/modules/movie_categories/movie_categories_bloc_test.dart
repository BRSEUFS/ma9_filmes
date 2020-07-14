import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:ma9filmes/app/modules/movie_categories/movie_categories_bloc.dart';
import 'package:ma9filmes/app/modules/movie_categories/movie_categories_module.dart';

void main() {
  initModule(MovieCategoriesModule());
  MovieCategoriesBloc bloc;

  // setUp(() {
  //     bloc = MovieCategoriesModule.to.bloc<MovieCategoriesBloc>();
  // });

  // group('MovieCategoriesBloc Test', () {
  //   test("First Test", () {
  //     expect(bloc, isInstanceOf<MovieCategoriesBloc>());
  //   });
  // });
}
