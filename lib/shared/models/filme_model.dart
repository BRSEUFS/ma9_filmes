import 'package:hive/hive.dart';

part 'filme_model.g.dart';

@HiveType(typeId: 0)
class FilmeModel extends HiveObject{

  @HiveField(0)
  String data;

  @HiveField(1)
  String genero;

  @HiveField(2)
  String link;

  @HiveField(3)
  String poster;

  @HiveField(4)
  String sinopse;

  @HiveField(5)
  String sinopseFull;

  @HiveField(6)
  String titulo;

  @HiveField(7)
  bool favorite;

  FilmeModel(
      {this.data,
      this.genero,
      this.link,
      this.poster,
      this.sinopse,
      this.sinopseFull,
      this.titulo,
      this.favorite = false});

  FilmeModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    genero = json['genero'];
    link = json['link'];
    poster = json['poster'];
    sinopse = json['sinopse'];
    sinopseFull = json['sinopseFull'];
    titulo = json['titulo'];
    favorite = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['genero'] = this.genero;
    data['link'] = this.link;
    data['poster'] = this.poster;
    data['sinopse'] = this.sinopse;
    data['sinopseFull'] = this.sinopseFull;
    data['titulo'] = this.titulo;
    return data;
  }
}
