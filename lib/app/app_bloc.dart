import 'package:bloc_pattern/bloc_pattern.dart';
import "dart:collection";
import 'package:ma9filmes/shared/models/filme_model.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc extends BlocBase {
  final _movies = BehaviorSubject<List<FilmeModel>>();
  final _searchResultMovies = BehaviorSubject<List<FilmeModel>>();
  final _genderResultMovies = BehaviorSubject<List<FilmeModel>>();
  final _genders = BehaviorSubject<List<String>>();
  final _movieTitleText = BehaviorSubject<String>();

  Stream<List<FilmeModel>> get movies => _movies.stream;
  Stream<List<FilmeModel>> get searchResultMovies => _searchResultMovies.stream;
  Stream<List<FilmeModel>> get genderResultMovies => _genderResultMovies.stream;
  Stream<List<String>> get genders => _genders.stream;
  Stream<String> get movieTitleText => _movieTitleText.stream;

  setMovies(List<FilmeModel> movies) {
    _movies.add(movies);
    _setGenders();
  }

  searchMovies(String title) {
    _movieTitleText.add(title);

    if (_movies.value.isNotEmpty) {
      var filtedList = _movies.value
          .where((f) => f.titulo.toLowerCase().startsWith(title.toLowerCase()))
          .toList();

      _searchResultMovies.add(filtedList);
    } else {
      _searchResultMovies
          .addError('Não foi possivel carregar o resultado da busca');
    }
  }

  _setGenders() {
    List<String> list = [];
    for (var movie in _movies.value) {
      List<String> categoriesSplit = movie.genero.split(',');

      if (categoriesSplit.isNotEmpty) {
        list = _genders.value== null?[]: _genders.value;


        for(var category in categoriesSplit){
          if(!list.contains(category.replaceAll(' ', ''))){
            list.add(category.replaceAll(' ', ''));
          }
        }

        list.sort((a, b) => a.toString().compareTo(b.toString()));

        _genders.add(list);
      }
    }
  }

  cleanSeach() {
    _movieTitleText.add('');
    _searchResultMovies.add([]);
  }

  @override
  void dispose() {
    super.dispose();
    _movies.close();
    _movieTitleText.close();
    _searchResultMovies.close();
    _genderResultMovies.close();
    _genders.close();
  }
}
