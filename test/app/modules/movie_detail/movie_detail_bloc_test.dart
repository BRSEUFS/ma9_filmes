import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:ma9filmes/app/modules/movie_detail/movie_detail_bloc.dart';
import 'package:ma9filmes/app/modules/movie_detail/movie_detail_module.dart';

void main() {
  initModule(MovieDetailModule());
  MovieDetailBloc bloc;

  // setUp(() {
  //     bloc = MovieDetailModule.to.bloc<MovieDetailBloc>();
  // });

  // group('MovieDetailBloc Test', () {
  //   test("First Test", () {
  //     expect(bloc, isInstanceOf<MovieDetailBloc>());
  //   });
  // });
}
