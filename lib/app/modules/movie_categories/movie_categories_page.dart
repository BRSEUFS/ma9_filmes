import 'package:flutter/material.dart';
import 'package:ma9filmes/app/app_bloc.dart';
import 'package:ma9filmes/app/app_module.dart';
import 'package:ma9filmes/shared/components/card_movie_detail.dart';
import 'package:ma9filmes/shared/models/filme_model.dart';

class MovieCategoriesPage extends StatefulWidget {
  final String title;
  const MovieCategoriesPage({Key key, this.title = "MovieCategories"})
      : super(key: key);

  @override
  _MovieCategoriesPageState createState() => _MovieCategoriesPageState();
}

class _MovieCategoriesPageState extends State<MovieCategoriesPage> {
  final bloc = AppModule.to.getBloc<AppBloc>();

  final pageController = PageController();

  var selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Colors.black87,
            body: PageView(
          controller: pageController,
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  child: StreamBuilder<List<String>>(
                      stream: bloc.categories,
                      builder: (context, snapshot) {
                        if (snapshot.hasData)
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    selected = snapshot.data[index];
                                    pageController.nextPage(
                                        duration: Duration(seconds: 1),
                                        curve: Curves.easeInOut);
                                    bloc.moviesByCategory(snapshot.data[index]);
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 60,
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '${snapshot.data[index]}',
                                          style: TextStyle(
                                              color: Color(0xffffffff),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: -0.12),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 10,
                                          color: Color(0xffffffff),
                                        )
                                      ],
                                    ),
                                  ));
                            },
                          );
                        else
                          return Container();
                      }),
                ),
              ],
            ),
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).padding.top,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.arrow_back_ios,color: Colors.white),
                            onPressed: () async {
                              pageController.previousPage(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.easeInBack);
                              await Future.delayed(Duration(seconds: 1));
                              bloc.cleanMoviesByCategory();
                            }),
                        Text(
                          selected != null ? selected : '',
                          style: TextStyle(fontSize: 19,color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<List<FilmeModel>>(
                        stream: bloc.genderResultMovies,
                        builder: (context, snapshot) {
                          if (snapshot.hasData)
                            return ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(vertical: 0),
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
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
