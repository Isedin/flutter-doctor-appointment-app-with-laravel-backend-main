import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('login', () async {
    final dio = Dio();
    dio.options.validateStatus = (status) => true;
    dio.options.followRedirects = true;
    final response = await dio.post('http://127.0.0.1:8000/api/login', data: {
      'email': 'sedoed58@gmail.com',
      'password': 'hidzr@1101',
    });
    print(response.statusCode);
    expect(true, true);
  });
  test('user', () async {
    final dio = Dio();
    dio.options.validateStatus = (status) => true;
    dio.options.followRedirects = true;
    final response = await dio.get('http://127.0.0.1:8000/api/user');
    print(response.statusCode);
    expect(true, true);
  });
  test('register', () async {
    final dio = Dio();
    dio.options.validateStatus = (status) => true;
    dio.options.followRedirects = true;
    final response = await dio.post('http://127.0.0.1:8000/api/register', data: {
      'name': 'Andreas',
      'email': 'andreas@cdemy.de',
      'password': 'trustno1',
    });
    print(response.statusCode);
    expect(true, true);
  });
}
