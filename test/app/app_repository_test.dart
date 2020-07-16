import 'package:flutter_test/flutter_test.dart';
import 'package:ma9filmes/shared/custom_dio/CustomDio.dart';
import 'package:ma9filmes/shared/models/response_model.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';

import 'package:ma9filmes/app/app_repository.dart';

class MockClient extends Mock implements CustomDio {}

void main() {
  AppRepository repository;
  MockClient client;

  setUp(() {
    client = MockClient();
    repository = AppRepository(client);
  });

  group('AppRepository Test', () {
    test("First Test", () {
      expect(repository, isInstanceOf<AppRepository>());
    });

    test('returns a Post if the http call completes successfully', () async {
      when(client.get('https://filmespy.herokuapp.com/api/v1/filmes'))
          .thenAnswer(
              (_) async => Response(data: {'titulo': 'Test'}, statusCode: 200));
      ResponseModel data = await repository.getFilmes();
      expect(data.data['titulo'], 'Test');
    });
  });
}
