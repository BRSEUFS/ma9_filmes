import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ma9filmes/app/app_bloc.dart';
import 'package:ma9filmes/app/app_module.dart';
import 'package:ma9filmes/app/modules/movie_detail/movie_detail_module.dart';
import 'package:ma9filmes/shared/components/routes/fade_route.dart';
import 'package:ma9filmes/shared/models/filme_model.dart';

class CardMovie extends StatefulWidget {
  final int index;
  FilmeModel filme;

  CardMovie({@required this.filme, @required this.index});

  @override
  _CardMovieState createState() => _CardMovieState();
}

class _CardMovieState extends State<CardMovie> {
  final bloc = AppModule.to.getBloc<AppBloc>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(FadeRoute(page: MovieDetailModule(widget.filme)));
        },
        child: Container(
            width: double.infinity,
            height: 400,
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    imageUrl: widget.filme.poster,
                    width: 170,
                    height: 250,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: 170,
                      height: 170,
                      color: Colors.grey[200],
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: Container(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 170,
                      height: 170,
                      color: Colors.grey[200],
                      child: Container(),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: IconButton(
                    icon: widget.filme.favorite
                        ? Icon(
                            FontAwesomeIcons.solidHeart,
                            color: Colors.red,
                          )
                        : Icon(
                            FontAwesomeIcons.heart,
                            color: Colors.white,
                          ),
                    onPressed: () async {
                      if (!widget.filme.favorite)
                        await bloc.favoriteMovie(

                            context , widget.filme, index: widget.index);
                      else
                        await bloc.removeFavoriteMovie(
                             widget.filme, index: widget.index);

                      setState(() {});
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }
}
