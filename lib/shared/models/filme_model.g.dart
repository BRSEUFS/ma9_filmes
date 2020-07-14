// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filme_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FilmeModelAdapter extends TypeAdapter<FilmeModel> {
  @override
  final typeId = 0;

  @override
  FilmeModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FilmeModel(
      data: fields[0] as String,
      genero: fields[1] as String,
      link: fields[2] as String,
      poster: fields[3] as String,
      sinopse: fields[4] as String,
      sinopseFull: fields[5] as String,
      titulo: fields[6] as String,
      favorite: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, FilmeModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.data)
      ..writeByte(1)
      ..write(obj.genero)
      ..writeByte(2)
      ..write(obj.link)
      ..writeByte(3)
      ..write(obj.poster)
      ..writeByte(4)
      ..write(obj.sinopse)
      ..writeByte(5)
      ..write(obj.sinopseFull)
      ..writeByte(6)
      ..write(obj.titulo)
      ..writeByte(7)
      ..write(obj.favorite);
  }
}
