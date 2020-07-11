import 'package:dio/dio.dart';
import 'package:ma9filmes/shared/models/response_model.dart';

class CustomIntercetors extends Interceptor {

  @override
  onRequest(RequestOptions options) async {
    return options;
  }

  @override
  onResponse(Response response) {
    return super.onResponse(response);
  }

  @override
  onError(DioError e) async {
    if (e.response.statusCode == 400)
      return ResponseModel(sucess: false, errors: [e.response.data['message']]);
    if (e.response.statusCode == 404)
      return ResponseModel(sucess: false, errors: [e.response.data['message']]);
    if (e.response.statusCode == 422)
      return ResponseModel(sucess: false, errors: [e.response.data['message']]);
    if (e.response.statusCode == 500)
      return ResponseModel(sucess: false, errors: [e.response.data['message']]);

    return ResponseModel(sucess: false);
  }
}
