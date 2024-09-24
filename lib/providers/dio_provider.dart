// in order to connect to database, we have to create dio provider first to post/get data fron laravel database. Since we use laravel sanctum, an API Token is needed for getting data from database.

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

class DioProvider {
  // get token
  Future<dynamic> getToken(String email, String password) async {
    try {
      dio.options.followRedirects = true;
      var response = await dio.post('http://10.0.2.2:8000/api/login', data: {
        'email': email,
        'password': password,
      });
      // if request successfully, then return token
      if (response.statusCode == 200 && response.data != '') {
        //store returned token into share preferences to get user data later
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.data);
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return error;
    }
  }

// the url "http://127.0.0.1:8000" is local database
// "api/login" is the route to get token that will be set later in laravel

//get user data
  Future<dynamic> getUser(String token) async {
    try {
      var user =
          await dio.get('http://10.0.2.2:8000/api/user', options: Options(headers: {'Authorization': 'Bearer $token'}));
      // if request successfully, then return user data
      if (user.statusCode == 200 && user.data != '') {
        return json.encode(user.data);
      }
    } catch (error) {
      return error;
    }
  }

//register new user
  Future<dynamic> registerUser(String username, String email, String password) async {
    try {
      var user = await dio
          .post('http://10.0.2.2:8000/api/register', data: {'email': email, 'name': username, 'password': password});
      // if request successfully, then return true
      if (user.statusCode == 200 && user.data != '') {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return error;
    }
  }
}