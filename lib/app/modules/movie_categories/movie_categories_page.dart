import 'package:flutter/material.dart';

class MovieCategoriesPage extends StatefulWidget {
  final String title;
  const MovieCategoriesPage({Key key, this.title = "MovieCategories"})
      : super(key: key);

  @override
  _MovieCategoriesPageState createState() => _MovieCategoriesPageState();
}

class _MovieCategoriesPageState extends State<MovieCategoriesPage> {
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
