import 'package:flutter/material.dart';
import 'package:ma9filmes/app/app_bloc.dart';
import 'package:ma9filmes/app/app_module.dart';

class MovieCategoriesPage extends StatefulWidget {
  final String title;
  const MovieCategoriesPage({Key key, this.title = "MovieCategories"})
      : super(key: key);

  @override
  _MovieCategoriesPageState createState() => _MovieCategoriesPageState();
}

class _MovieCategoriesPageState extends State<MovieCategoriesPage> {

  final bloc = AppModule.to.getBloc<AppBloc>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
          body: Column(
            children: <Widget>[
              Expanded(
                child: StreamBuilder<List<String>>(
                    stream: bloc.genders,
                    builder: (context, snapshot) {

                      if(snapshot.hasData)
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
//                                Navigator.push(
//                                  context,
//                                  AppRoute.getAppRoute(
//                                    MovieDetailModule(widget.movie),
//                                  ),
//                                );
                              },
                              child: Container(
                                height: 68,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '${snapshot.data[index]}',
                                      style: TextStyle(
                                          color: Color(0xff000000),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: -0.12),
                                    ),
                                  ],
                                ),
                              )
                            );
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
