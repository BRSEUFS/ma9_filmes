import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ma9filmes/app/app_bloc.dart';
import 'package:ma9filmes/app/app_module.dart';
import 'package:ma9filmes/shared/components/card_movie_detail.dart';
import 'package:ma9filmes/shared/models/filme_model.dart';

class MovieFavoritesPage extends StatefulWidget {
  final String title;
  const MovieFavoritesPage({Key key, this.title = "MovieFavorites"})
      : super(key: key);

  @override
  _MovieFavoritesPageState createState() => _MovieFavoritesPageState();
}

class _MovieFavoritesPageState extends State<MovieFavoritesPage> {
  final bloc = AppModule.to.getBloc<AppBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: StreamBuilder<List<FilmeModel>>(
          stream: bloc.moviesFavorites,
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return CardMovieDetail(
                    movie: snapshot.data[index],
                  );
                },
              );
            else
              return Container();
          }),
    );
  }
}
