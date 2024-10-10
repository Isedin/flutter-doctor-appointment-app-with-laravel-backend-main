import 'package:dio/dio.dart';
import 'package:doctor_appointment_app_with_laravel_backend/components/button.dart';
import 'package:doctor_appointment_app_with_laravel_backend/main.dart';
import 'package:doctor_appointment_app_with_laravel_backend/models/auth_model.dart';
import 'package:doctor_appointment_app_with_laravel_backend/providers/dio_provider.dart';
import 'package:doctor_appointment_app_with_laravel_backend/utils/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
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
              return Column(
                children: [
                  Button(
                    width: double.infinity,
                    title: 'Sign In',
                    onPressed: () async {
                      //login here
                      final token = await DioProvider().getToken(_emailController.text, _passController.text);
                      if (token is! DioException) {
                        auth.loginSuccess(); // update login status
                        //redirect to main page
                        MyApp.navigatorKey.currentState!.pushNamed('main');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Invalid email or password'),
                          backgroundColor: Colors.red,
                        ));
                      }
                    },
                    disable: false,
                  ),
                  if (kDebugMode)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Button(
                        width: double.infinity,
                        title: 'Test Sign In',
                        onPressed: () async {
                          //login here
                          final token = await DioProvider().getToken('andreas@email.com', '123456789');
                          if (token is! DioException) {
                            auth.loginSuccess(); // update login status
                            //redirect to main page
                            MyApp.navigatorKey.currentState!.pushNamed('main');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Invalid email or password'),
                              backgroundColor: Colors.red,
                            ));
                          }
                        },
                        disable: false,
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
