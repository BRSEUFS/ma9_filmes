import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ma9filmes/app/app_module.dart';
import 'package:ma9filmes/shared/models/filme_model.dart';

Future<void> main() async {
  var path = Directory.current.path;
  Hive
    ..init(path)
    ..registerAdapter<FilmeModel>(FilmeModelAdapter());

  runApp(AppModule());
}
