import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:ma9filmes/shared/custom_dio/CustomDio.dart';
import 'package:ma9filmes/shared/models/filme_model.dart';
import 'package:ma9filmes/shared/models/response_model.dart';

class FilmeRepository extends Disposable {
  final CustomDio _client;

  FilmeRepository(this._client);

  Future<ResponseModel> getFilmes() async {
    var response;

    try {
      response = await _client.get('/filmes');

      if (response.statusCode == 200) {
        var filmes = List<FilmeModel>.from(
            response.data['filmes'].map((x) => FilmeModel.fromJson(x)));

        return ResponseModel(sucess: true, data: filmes);
      }
    } on DioError catch (e) {
      response = e.error;
      return response;
    }
  }

  @override
  void dispose() {}
}
