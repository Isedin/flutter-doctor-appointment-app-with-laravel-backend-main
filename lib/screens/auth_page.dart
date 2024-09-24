import 'package:doctor_appointment_app_with_laravel_backend/components/login_form.dart';
import 'package:doctor_appointment_app_with_laravel_backend/components/sign_up_form.dart';
import 'package:doctor_appointment_app_with_laravel_backend/components/social_button.dart';
import 'package:doctor_appointment_app_with_laravel_backend/utils/config.dart';
import 'package:doctor_appointment_app_with_laravel_backend/utils/text.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isSignedIn = true;
  @override
  Widget build(BuildContext context) {
    Config.init(context);
    // build login text field
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppText.enText['welcome_text']!,
                style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              Config.spaceSmall,
              Text(
                isSignedIn ? AppText.enText['signIn_text']! : AppText.enText['signUp_text']!,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Config.spaceSmall,
              // login components here
              isSignedIn ? LoginForm() : SignUpForm(),
              Config.spaceSmall,
              isSignedIn
                  ? Center(
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            AppText.enText['forgot_password']!,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                          )),
                    )
                  : Container(),
              // add social button sign in
              const Spacer(),
              Center(
                child: Text(
                  AppText.enText['social-login']!,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey.shade500),
                ),
              ),
              Config.spaceSmall,
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SocialButton(social: 'google'),
                  SocialButton(social: 'facebook'),
                ],
              ),
              Config.spaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    isSignedIn ? AppText.enText['signIn_text']! : AppText.enText['signUp_text']!,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey.shade500),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isSignedIn = !isSignedIn;
                      });
                    },
                    child: Text(isSignedIn ? 'Sign Up' : 'Sign In',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
