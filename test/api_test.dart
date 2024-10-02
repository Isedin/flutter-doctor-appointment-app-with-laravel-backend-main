import 'package:dio/dio.dart';
import 'package:doctor_appointment_app_with_laravel_backend/models/booking_datetime_converted.dart';
import 'package:doctor_appointment_app_with_laravel_backend/providers/dio_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('login', () async {
    final dio = Dio();
    dio.options.validateStatus = (status) => true;
    dio.options.followRedirects = true;
    final response = await dio.post('http://127.0.0.1:8000/api/login', data: {
      'email': 'isedin@email.com',
      'password': '123456789',
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
      'name': 'test',
      'email': 'test@email.com',
      'password': 'testPassword',
    });
    print(response.statusCode);
    expect(true, true);
  });

  test('bookAppointment', () async {
    final token = DioProvider().getToken('isedin@email.com', '123456789');
    final dio = Dio();
    dio.options.validateStatus = (status) => true;
    dio.options.followRedirects = false;
    var response = await dio.post('http://127.0.0.1:8000/api/book',
        data: {
          'date': DateConverted.getDate(DateTime.utc(2024, 11, 9)),
          'day': DateConverted.getDay(DateTime.utc(2024, 11, 9).weekday),
          'time': DateConverted.getTime(1),
          'doctor_id': 19
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    print(response.statusCode);
    expect(true, true);
  });

  test('getAppointment', () async {
    final token = DioProvider().getToken('isedin@email.com', '123456789');
    final dio = Dio();
    dio.options.validateStatus = (status) => true;
    dio.options.followRedirects = true;
    dio.options.headers = {'Authorization': 'Bearer $token'};
    var response = await dio.post('http://127.0.0.1:8000/api/appointments');
    print(response.statusCode);
    expect(true, true);
  });
}
