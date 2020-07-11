import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';

import 'CustomIntercetors.dart';


class CustomDio extends DioForNative{

  CustomDio(){
    options.baseUrl = 'https://filmespy.herokuapp.com/api/v1';
    options.connectTimeout = 10000; //5s
    options.receiveTimeout = 3000;
    interceptors.add(CustomIntercetors());
  }

}
