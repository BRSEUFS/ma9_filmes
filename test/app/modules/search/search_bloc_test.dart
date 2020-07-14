import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:ma9filmes/app/modules/search/search_bloc.dart';
import 'package:ma9filmes/app/modules/search/search_module.dart';

void main() {
  initModule(SearchModule());
  SearchBloc bloc;

  // setUp(() {
  //     bloc = SearchModule.to.bloc<SearchBloc>();
  // });

  // group('SearchBloc Test', () {
  //   test("First Test", () {
  //     expect(bloc, isInstanceOf<SearchBloc>());
  //   });
  // });
}
