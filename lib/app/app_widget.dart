import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:ma9filmes/app/modules/home/home_module.dart';
import 'package:ma9filmes/app/modules/splash/splash_page.dart';
import 'package:path_provider/path_provider.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      title: 'Flutter Slidy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<Box>(
          future: _abrirCaixa(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.error != null) {
                //TODO: Criar modulo de erro
                return Scaffold(
                  body: Center(
                    child: Text('algo deu errado!'),
                  ),
                );
              } else {
                return HomeModule();
              }
            } else {
              return SplashPage();
            }
            return HomeModule();
          }),
    );
  }

  Future<Box> _abrirCaixa() async {
    var dir = await getApplicationDocumentsDirectory();

    Hive.init(dir.path);

    var box = await Hive.openBox('ma9filmes');

    return box;
  }
}
