// import 'dart:convert';
import 'package:doctor_appointment_app_with_laravel_backend/providers/dio_models.dart';
import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier {
  bool _isLogin = false;
  UserModel? user; //update user details when login success
  DoctorModel? doctorModel; //update appointment details when login success
  List<DoctorModel> favDoc = []; //get latest favorite doctor
  List<int> _fav = []; // get all favorite doctor id in list

  bool get isLogin {
    return _isLogin;
  }

  List<int> get getFav {
    return _fav;
  }

  UserModel? get getUser {
    return user;
  }

  DoctorModel? get getDoctorModel {
    return doctorModel;
  }

  //update lateset favorite list and notify all widgets
  void setFavList(List<int> list) {
    _fav = list;
    notifyListeners();
  }

  //return latest favorite doctor list
  List<DoctorModel> get getFavDoc {
    favDoc.clear(); // clear all previous record before get latest list

    //list out doctor list according to favorite list
    for (var num in _fav) {
      for (var doc in user?.doctors ?? <DoctorModel>[]) {
        if (num ==doc.id) {
          favDoc.add(doc);
        }
      }
    }
    return favDoc;
  }

// when login success, update the status
  void loginSuccess(UserModel userData, DoctorModel? loggedInDoctor) {
    _isLogin = true;

    //update user and appointment info every time login success
    user = userData;
    doctorModel = loggedInDoctor;
    print('user data in model: $user');
    //because initially the fav list is NULL, we have to check if it is NULL or not
    if (user?.details?.fav != null) {
      _fav = user?.details?.fav ?? []; //the details are returned from user controller
    }
    notifyListeners();
  }
}
