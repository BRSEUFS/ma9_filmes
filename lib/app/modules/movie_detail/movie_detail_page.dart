import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ma9filmes/app/app_module.dart';
import 'package:ma9filmes/shared/models/filme_model.dart';

import '../../app_bloc.dart';

class MovieDetailPage extends StatefulWidget {
  FilmeModel filme;
  MovieDetailPage({Key key, @required this.filme}) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final bloc = AppModule.to.getBloc<AppBloc>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Color gradientStart = Colors.transparent;
    Color gradientEnd = Colors.black87;

    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              //height: double.infinity,
              color: Colors.black,
              child: Stack(
                //fit: StackFit.expand,
                overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                    height: size.height,
                    alignment: Alignment.topCenter,
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.transparent],
                        ).createShader(
                            Rect.fromLTRB(0, -300, rect.width, rect.height));
                      },
                      blendMode: BlendMode.dstIn,
                      child: Image.network(
                        widget.filme.poster,
                        width: size.width,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Container(
                    width: size.width,
                    margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: MediaQuery.of(context).size.height * .25,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Chip(
                          label: Text(widget.filme.data.split('/')[2]),
                        ),
                        Container(
                          width: size.width,
                          margin: EdgeInsets.only(right: 20),
                          child: Text(
                            widget.filme.titulo,
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Row(children: ChipsGenero(widget.filme.genero)),
                        Container(
                          width: size.width - 40,
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: Text(
                            widget.filme.sinopseFull
                                .replaceFirst('\n', '')
                                .replaceFirst('                      ', ''),
                            textAlign: TextAlign.justify,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 50,
                    child: Container(
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                          IconButton(
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
                                if (bloc.canFavorite()) {
                                  widget.filme.favorite =
                                      !widget.filme.favorite;

                                  if (widget.filme.favorite) {
                                    await bloc.favoriteMovie(
                                        context, widget.filme);
                                  } else {
                                    await bloc
                                        .removeFavoriteMovie(widget.filme);
                                  }
                                } else {
                                  var snackBar = SnackBar(
                                      content: Text(
                                          'Você só pode favoritar 3 filmes!'));
                                  _scaffoldKey.currentState.showSnackBar(snackBar);
                                }

                                setState(() {});
                              })
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Container> ChipsGenero(String genero) {
    var generoSplit = genero.split(',');
    List<Container> chips = [];

    for (var gen in generoSplit) {
      chips.add(Container(
        margin: EdgeInsets.only(right: 10),
        child: Chip(
          label: Text(gen),
        ),
      ));
    }

    return chips;
  }
}
