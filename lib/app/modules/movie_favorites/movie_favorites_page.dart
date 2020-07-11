import 'package:flutter/material.dart';

class MovieFavoritesPage extends StatefulWidget {
  final String title;
  const MovieFavoritesPage({Key key, this.title = "MovieFavorites"})
      : super(key: key);

  @override
  _MovieFavoritesPageState createState() => _MovieFavoritesPageState();
}

class _MovieFavoritesPageState extends State<MovieFavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
