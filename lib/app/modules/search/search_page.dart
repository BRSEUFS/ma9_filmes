import 'package:flutter/material.dart';
import 'package:ma9filmes/app/app_bloc.dart';
import 'package:ma9filmes/app/app_module.dart';
import 'package:ma9filmes/shared/components/card_movie_detail.dart';
import 'package:ma9filmes/shared/models/filme_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final bloc = AppModule.to.getBloc<AppBloc>();

  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
          backgroundColor: Colors.black87,
          body: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).padding.top),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: textEditingController,
                  style: TextStyle(color: Colors.white),
                  onChanged: (value) {
                    bloc.searchMovies(value);
                  },
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: 'Search Movies',
                    hintStyle: TextStyle(color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(32.0)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<List<FilmeModel>>(
                    stream: bloc.searchResultMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasData)
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          padding: EdgeInsets.symmetric(vertical: 0),
                          itemBuilder: (context, index) {
                            return CardMovieDetail(
                              movie: snapshot.data[index],
                            );
                          },
                        );
                      else
                        return Container();
                    }),
              ),
            ],
          )),
    );
  }
}
