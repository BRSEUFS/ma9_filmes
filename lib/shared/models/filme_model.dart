import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class FilmeModel {
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

  FilmeModel(
      {this.data,
      this.genero,
      this.link,
      this.poster,
      this.sinopse,
      this.sinopseFull,
      this.titulo});

  FilmeModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    genero = json['genero'];
    link = json['link'];
    poster = json['poster'];
    sinopse = json['sinopse'];
    sinopseFull = json['sinopseFull'];
    titulo = json['titulo'];
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
