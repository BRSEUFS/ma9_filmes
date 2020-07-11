import 'package:flutter/material.dart';
import 'package:ma9filmes/app/app_bloc.dart';
import 'package:ma9filmes/app/app_module.dart';
import 'package:ma9filmes/shared/components/card_movie_detail.dart';
import 'package:ma9filmes/shared/models/filme_model.dart';

class SearchPage extends StatefulWidget {
  final String title;
  const SearchPage({Key key, this.title = "Search"}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final bloc = AppModule.to.getBloc<AppBloc>();

  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
          body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: textEditingController,
              onChanged: (value){
                bloc.searchMovies(value);
              },
              decoration: InputDecoration(
                hintText: 'Search Movies',
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<FilmeModel>>(
              stream: bloc.searchResultMovies,
              builder: (context, snapshot) {

                if(snapshot.hasData)
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return CardMovieDetail(movie: snapshot.data[index],);
                  },
                );
                else
                  return Container();
              }
            ),
          ),
        ],
      )),
    );
  }
}
