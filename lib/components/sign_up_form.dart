import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:doctor_appointment_app_with_laravel_backend/components/button.dart';
import 'package:doctor_appointment_app_with_laravel_backend/main.dart';
import 'package:doctor_appointment_app_with_laravel_backend/models/auth_model.dart';
import 'package:doctor_appointment_app_with_laravel_backend/providers/dio_provider.dart';
import 'package:doctor_appointment_app_with_laravel_backend/utils/config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool obsecurePass = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.text,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Username',
              labelText: 'Username',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.person_outlined),
              prefixIconColor: Config.primaryColor,
            ),
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Email',
              labelText: 'Email',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.email_outlined),
              prefixIconColor: Config.primaryColor,
            ),
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _passController,
            keyboardType: TextInputType.visiblePassword,
            cursorColor: Config.primaryColor,
            obscureText: obsecurePass,
            decoration: InputDecoration(
                hintText: 'Password',
                labelText: 'Password',
                alignLabelWithHint: true,
                prefixIcon: const Icon(Icons.lock_outline),
                prefixIconColor: Config.primaryColor,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obsecurePass = !obsecurePass;
                      });
                    },
                    icon: obsecurePass
                        ? const Icon(
                            Icons.visibility_off_outlined,
                            color: Colors.black38,
                          )
                        : const Icon(Icons.visibility_outlined, color: Config.primaryColor))),
          ),
          Config.spaceSmall,
          // login button
          Consumer<AuthModel>(
            builder: (context, auth, child) {
              return Button(
                width: double.infinity,
                title: 'Sign Up',
                onPressed: () async {
                  log('name: ${_nameController.text}');
                  log('email: ${_emailController.text}');
                  log('password: ${_passController.text}');
                  final userRegistration = await DioProvider().registerUser(
                    _nameController.text,
                    _emailController.text,
                    _passController.text,
                  );
                  log('register: $userRegistration');
                  //if register success, proceed to login
                  print(1);
                  if (userRegistration is! DioException) {
                    print(2);
                    print('test');
                    final tokenSuccess = await DioProvider().getToken(
                      _emailController.text,
                      _passController.text,
                    );
                    log('token: $tokenSuccess');
                    if (tokenSuccess) {
                      print(3);
                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                      final token = prefs.getString('token') ?? '';
                      //get user data
                      final newUserData = await DioProvider().getUser(token);
                      print(newUserData);
                      if (newUserData != null) {
                        print(4);
                        //update login status
                        auth.loginSuccess(newUserData, null);
                        //rediret to main page
                        MyApp.navigatorKey.currentState!.pushNamed('main');
                        // auth.loginSuccess(newUserData, {}); //update login status
                        //rediret to main page
                        // MyApp.navigatorKey.currentState!.pushNamed('main');
                      }
                    }
                  } else {
                    print('register not successful');
                  }
                },
                disable: false,
              );
            },
          ),
        ],
      ),
    );
  }
}
