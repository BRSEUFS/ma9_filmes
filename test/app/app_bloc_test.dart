import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:ma9filmes/app/app_bloc.dart';
import 'package:ma9filmes/app/app_module.dart';
import 'package:ma9filmes/app/app_repository.dart';
import 'package:ma9filmes/shared/custom_dio/CustomDio.dart';
import 'package:ma9filmes/shared/models/filme_model.dart';
import 'package:mockito/mockito.dart';

class MockAppRepository extends Mock implements AppRepository {}

class MockCustomDio extends Mock implements CustomDio {}

void main() {
  initModule(AppModule());
  AppBloc bloc;
  MockCustomDio client;

  setUp(() {
    bloc = AppModule.to.bloc<AppBloc>();
    client = MockCustomDio();
  });

  group('AppBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<AppBloc>());
    });

    test('Can favorite', () {
      bloc.addFavoriteMovie(FilmeModel());
      bloc.addFavoriteMovie(FilmeModel());
      expect(bloc.canFavorite(), true);
    });

    test('Can\'t favorite', () {
      expect(bloc.canFavorite(), true);
      bloc.addFavoriteMovie(FilmeModel());
      bloc.addFavoriteMovie(FilmeModel());
      expect(bloc.canFavorite(), true);
      bloc.addFavoriteMovie(FilmeModel());
      bloc.addFavoriteMovie(FilmeModel());
      expect(bloc.canFavorite(), false);
    });

    test('Stream listen test', () {
      var stream = bloc.moviesFavorites;

      final FilmeModel value = FilmeModel(titulo: 'Unit test');

      expectLater(stream, emits([value]));

      bloc.addFavoriteMovie(value);
    });

    test('Select movie by category', () {

      var stream = bloc.genderResultMovies;

      final FilmeModel A =
          FilmeModel(titulo: 'Unit test A', genero: 'A, B, C, D');
      final FilmeModel B = FilmeModel(titulo: 'Unit test B', genero: 'B, C');
      final FilmeModel C = FilmeModel(titulo: 'Unit test C', genero: 'A, D');
      final FilmeModel D = FilmeModel(titulo: 'Unit test D', genero: 'B, C, D');

      expectLater(stream, emits([A,C]));

//       bloc.addMovie(A);
//       bloc.addMovie(B);
//       bloc.addMovie(C);
//       bloc.addMovie(D);
      bloc.moviesByCategory('A');
    });
  });
}
