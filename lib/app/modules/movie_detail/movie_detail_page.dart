import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ma9filmes/shared/models/filme_model.dart';

class MovieDetailPage extends StatefulWidget {
  final FilmeModel filme;
  const MovieDetailPage({Key key, this.filme}) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Color gradientStart = Colors.transparent;
    Color gradientEnd = Colors.black87;

    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          height: 2000,
          color: Colors.black,
          child: Stack(
            fit: StackFit.expand,
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
                    ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image.network(
                    widget.filme.poster,
                    width: size.width,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Positioned(
                top: 220,
                child: Container(
                  width: size.width,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Chip(
                        label: Text(widget.filme.data.split('/')[2]),
                      ),
                      Container(
                        width: size.width,
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
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          widget.filme.sinopseFull,
                          textAlign: TextAlign.justify,
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
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
                          icon: Icon(
                            FontAwesomeIcons.heart,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ],
                  ),
                ),
              )
            ],
          ),
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
