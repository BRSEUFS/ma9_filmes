import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ma9filmes/app/modules/movie_detail/movie_detail_module.dart';
import 'package:ma9filmes/shared/components/routes/app_route.dart';
import 'package:ma9filmes/shared/models/filme_model.dart';

class CardMovieDetail extends StatefulWidget {
  final FilmeModel movie;

  const CardMovieDetail({Key key, this.movie}) : super(key: key);

  @override
  _CardMovieDetailState createState() => _CardMovieDetailState();
}

class _CardMovieDetailState extends State<CardMovieDetail> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          AppRoute.getAppRoute(
            MovieDetailModule(widget.movie),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        //color: Colors.grey[100],
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        imageUrl: widget.movie.poster,
                        height: 110,
                        width: 83,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          height: 100,
                          width: 83,
                          color: Colors.grey[200],
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: 68,
                          width: 83,
                          color: Colors.grey[200],
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: Image.asset(
                              'assets/images/error/error.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 17,
                    ),
                    Container(
                      height: 68,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${widget.movie.titulo}',
                            style: TextStyle(
                                color: Color(0xffffffff),
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.12),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Ano ${widget.movie.data.split('/')[2]}',
                            style: TextStyle(
                                color: Color(0xccffffff),
                                fontSize: 9,
                                letterSpacing: -0.1),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            '${widget.movie.genero}',
                            style: TextStyle(
                                color: Color(0xccffffff),
                                fontSize: 9,
                                letterSpacing: -0.1),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              color: Colors.grey[100],
              height: 1,
              width: MediaQuery.of(context).size.width * .7,
            )
          ],
        ),
      ),
    );
  }
}
