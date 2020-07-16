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
  final _moviesFavorites = BehaviorSubject<List<FilmeModel>>.seeded([]);
  final _searchResultMovies = BehaviorSubject<List<FilmeModel>>();
  final _genderResultMovies = BehaviorSubject<List<FilmeModel>>();
  final _categories = BehaviorSubject<List<String>>();
  final _movieTitleText = BehaviorSubject<String>();
  final _isLoading = BehaviorSubject<bool>();

  final AppRepository _repo;

  Stream<List<FilmeModel>> get movies => _movies.stream;
  Stream<List<FilmeModel>> get moviesFavorites => _moviesFavorites.stream;
  Stream<List<FilmeModel>> get searchResultMovies => _searchResultMovies.stream;
  Stream<List<FilmeModel>> get genderResultMovies => _genderResultMovies.stream;
  Stream<List<String>> get categories => _categories.stream;
  Stream<String> get movieTitleText => _movieTitleText.stream;
  Stream<bool> get isLoading => _isLoading.stream;

  AppBloc(this._repo) {
    _getData();
  }

  _getData() async {
    await _loadfavoritesMovies();
    await _getFilmes();
  }

  _getFilmes() async {
    _isLoading.add(true);
    var response = await _repo.getFilmes();

    if (response.sucess) {
      _movies.add(response.data);
      _setCategories();
      await _setMovies();
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
    }
  }

  _setCategories() {
    List<String> list = [];
    for (var movie in _movies.value) {
      List<String> categoriesSplit = movie.genero.split(',');

      if (categoriesSplit.isNotEmpty) {
        list = _categories.value == null ? [] : _categories.value;

        for (var category in categoriesSplit) {
          if (!list.contains(category.replaceAll(' ', ''))) {
            list.add(category.replaceAll(' ', ''));
          }
        }

        list.sort((a, b) => a.toString().compareTo(b.toString()));

        _categories.add(list);
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
    var box = await Hive.openBox<List<FilmeModel>>('ma9filmes');

    List<FilmeModel> movies = _movies.value != null ? _movies.value : [];
    List<FilmeModel> favorites =
        _moviesFavorites.value != null ? _moviesFavorites.value : [];

    var snackBar;

    if (index != null) {
      if (favorites.length < 3) {
        movie.favorite = true;
        movies[index] = movie;

        favorites.add(movie);

        _movies.add(movies);
        _moviesFavorites.add(favorites);
        await box.put('favorites', favorites);

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

          favorites.add(movie);

          _movies.add(movies);
          _moviesFavorites.add(favorites);
          await box.put('favorites', favorites);
        }
      }
    }
  }

  removeFavoriteMovie(FilmeModel movie, {int index}) async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    var box = await Hive.openBox<List<FilmeModel>>('ma9filmes');

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

    _movies.add(movies);
    _moviesFavorites.add(favorites);
    await box.put('favorites', favorites);
  }

  _loadfavoritesMovies() async {
    var dir = await getApplicationDocumentsDirectory();

    Hive.init(dir.path);

    var box = await Hive.openBox('ma9filmes');

    var fs = box.get('favorites', defaultValue: []).cast<FilmeModel>();

    _moviesFavorites.add(fs);
  }

  addMovie(FilmeModel movie) {
    List<FilmeModel> movies = _movies.value != null ? _movies.value : [];

    movies.add(movie);
    _movies.add(movies);
    _setMovies();
    _setCategories();
  }

  addFavoriteMovie(FilmeModel movie) {
    List<FilmeModel> favorites =
        _moviesFavorites.value != null ? _moviesFavorites.value : [];

    favorites.add(movie);
    _moviesFavorites.add(favorites);
  }

  bool canFavorite() {
    if (_moviesFavorites.value.length <= 3) {
      return true;
    } else {
      return false;
    }
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
    _categories.close();
    _isLoading.close();
  }
}
