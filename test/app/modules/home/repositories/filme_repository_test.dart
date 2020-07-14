import 'package:flutter_test/flutter_test.dart';
import 'package:ma9filmes/shared/custom_dio/CustomDio.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';

import 'package:ma9filmes/app/modules/home/repositories/filme_repository.dart';

class MockClient extends Mock implements CustomDio {}

void main() {
  FilmeRepository repository;
   MockClient client;

  setUp(() {
     repository = FilmeRepository(client);
      client = MockClient();
  });

  group('FilmeRepository Test', () {
    //  test("First Test", () {
    //    expect(repository, isInstanceOf<FilmeRepository>());
    //  });

    test('returns a Post if the http call completes successfully', () async {
      //    when(client.get('https://jsonplaceholder.typicode.com/posts/1'))
      //        .thenAnswer((_) async =>
      //            Response(data: {'title': 'Test'}, statusCode: 200));
      //    Map<String, dynamic> data = await repository.fetchPost(client);
      //    expect(data['title'], 'Test');
    });
  });
}
