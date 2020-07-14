import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ma9filmes/shared/models/filme_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

import 'app_repository.dart';

class AppBloc extends BlocBase {
  final _movies = BehaviorSubject<List<FilmeModel>>();
  final _moviesFavorites = BehaviorSubject<List<FilmeModel>>();
  final _searchResultMovies = BehaviorSubject<List<FilmeModel>>();
  final _genderResultMovies = BehaviorSubject<List<FilmeModel>>();
  final _genders = BehaviorSubject<List<String>>();
  final _movieTitleText = BehaviorSubject<String>();
  final _isLoading = BehaviorSubject<bool>();

  final AppRepository _repo;

  Stream<List<FilmeModel>> get movies => _movies.stream;
  Stream<List<FilmeModel>> get moviesFavorites => _moviesFavorites.stream;
  Stream<List<FilmeModel>> get searchResultMovies => _searchResultMovies.stream;
  Stream<List<FilmeModel>> get genderResultMovies => _genderResultMovies.stream;
  Stream<List<String>> get genders => _genders.stream;
  Stream<String> get movieTitleText => _movieTitleText.stream;
  Stream<bool> get isLoading => _isLoading.stream;

  bool _canFavorite = true;

  AppBloc(this._repo) {
    _getData();
  }

  _getData() async {
    await _getFilmes();
    await _loadfavoritesMovies();
    await _setMovies();
  }

  _getFilmes() async {
    _isLoading.add(true);
    var response = await _repo.getFilmes();

    if (response.sucess) {
      _movies.add(response.data);
    } else {
      _movies.addError(response.errors);
    }
    _isLoading.add(false);
  }

  _setMovies() async {
    var favorites =
        _moviesFavorites.value != null ? _moviesFavorites.value : [];

    var movies = _movies.value != null ? _movies.value : [];

    if (favorites.isNotEmpty) {
      var index = 0;
      for (var movie in movies) {
        for (var f in favorites) {
          if (movie.titulo == f.titulo) {
            movies[index].favorite = !movies[index].favorite;
          }
        }
        index++;
      }
      _movies.add(movies);
    } else {
      _movies.add(movies);
    }

    _setGenders();
  }

  searchMovies(String title) {
    _movieTitleText.add(title);

    if (_movies.value.isNotEmpty) {
      var filtedList = _movies.value
          .where((f) => f.titulo.toLowerCase().startsWith(title.toLowerCase()))
          .toList();

      if (!(title == null || title == ''))
        _searchResultMovies.add(filtedList);
      else
        cleanSeach();
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
        list = _genders.value == null ? [] : _genders.value;

        for (var category in categoriesSplit) {
          if (!list.contains(category.replaceAll(' ', ''))) {
            list.add(category.replaceAll(' ', ''));
          }
        }

        list.sort((a, b) => a.toString().compareTo(b.toString()));

        _genders.add(list);
      }
    }
  }

  moviesByCategory(String cat) {
    var movies = [];

    for (var movie in _movies.value) {
      List<String> categoriesSplit = movie.genero.split(',');

      if (categoriesSplit.isNotEmpty) {
        List<FilmeModel> list =
            _genderResultMovies.value != null ? _genderResultMovies.value : [];

        for (var category in categoriesSplit) {
          if (category.contains(cat.replaceAll(' ', ''))) {
            list.add(movie);
          }
        }

        _genderResultMovies.add(list);
      }
    }
  }

  favoriteMovie(BuildContext context, FilmeModel movie, {int index}) async {
    var dir = await getApplicationDocumentsDirectory();

    Hive.init(dir.path);

    List<FilmeModel> movies = _movies.value != null ? _movies.value : [];
    List<FilmeModel> favorites =
        _moviesFavorites.value != null ? _moviesFavorites.value : [];

    var snackBar;

    if (index != null) {
      if (favorites.length < 3) {
        movie.favorite = true;
        movies[index] = movie;
        var box = await Hive.openBox<List<FilmeModel>>('ma9filmes');

        favorites.add(movie);

        if(favorites.length == 3){
          _canFavorite = false;
        }

        _movies.add(movies);
        _moviesFavorites.add(favorites);
        await box.put('favorites', favorites);
        await _loadfavoritesMovies();

        snackBar =
            SnackBar(content: Text('Você favoritou ${movies[index].titulo}'));
        Scaffold.of(context).showSnackBar(snackBar);
      } else {
        snackBar = SnackBar(content: Text('Você só pode favoritar 3 filmes!'));
        Scaffold.of(context).showSnackBar(snackBar);
      }
    } else {
      var index = _movies.value.indexWhere((f) => f.titulo == movie.titulo);

      if (!(index == -1)) {
        if (favorites.length < 3) {
          movie.favorite = true;
          movies[index] = movie;
          var box = await Hive.openBox<List<FilmeModel>>('ma9filmes');

          favorites.add(movie);

          if(favorites.length == 3){
            _canFavorite = false;
          }

          _movies.add(movies);
          _moviesFavorites.add(favorites);
          await box.put('favorites', favorites);
          await _loadfavoritesMovies();

//          snackBar =
//              SnackBar(content: Text('Você favoritou ${movies[index].titulo}'));
        } else {
//          snackBar =
//              SnackBar(content: Text('Você só pode favoritar 3 filmes!'));
        }
      } else {
//        snackBar = SnackBar(content: Text('Não foi possivel realizar ação!'));
      }
    }
  }

  removeFavoriteMovie(FilmeModel movie, {int index}) async {
    var dir = await getApplicationDocumentsDirectory();

    Hive.init(dir.path);

    List<FilmeModel> movies = _movies.value != null ? _movies.value : [];
    List<FilmeModel> favorites =
        _moviesFavorites.value != null ? _moviesFavorites.value : [];

    favorites.removeWhere((f) => f.titulo == movie.titulo);
    movie.favorite = false;

    if (index != null) {
      movies[index] = movie;
    } else {
      var index = _movies.value.indexWhere((f) => f.titulo == movie.titulo);
      movies[index] = movie;
    }
    _canFavorite  = true;
    var box = await Hive.openBox<List<FilmeModel>>('ma9filmes');

    _movies.add(movies);
    _moviesFavorites.add(favorites);
    await box.put('favorites', favorites);
    await _loadfavoritesMovies();
  }

  _loadfavoritesMovies() async {
    var dir = await getApplicationDocumentsDirectory();

    Hive.init(dir.path);

    var box = await Hive.openBox('ma9filmes');

    var fs = box.get('favorites', defaultValue: []).cast<FilmeModel>();

    _moviesFavorites.add(fs);
  }

  bool canFavorite(){
    return _canFavorite;
  }

  cleanMoviesByCategory() {
    _genderResultMovies.add([]);
  }

  cleanSeach() {
    _searchResultMovies.add([]);
  }

  @override
  void dispose() {
    super.dispose();
    _movies.close();
    _moviesFavorites.close();
    _movieTitleText.close();
    _searchResultMovies.close();
    _genderResultMovies.close();
    _genders.close();
    _isLoading.close();
  }
}
