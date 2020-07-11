import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';

class AppBloc extends BlocBase {


  action(){
    debugPrint('Teste');
  }
  @override
  void dispose() {
    super.dispose();
  }
}
