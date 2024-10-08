import 'package:doctor_appointment_app_with_laravel_backend/models/auth_model.dart';
import 'package:doctor_appointment_app_with_laravel_backend/screens/auth_page.dart';
import 'package:doctor_appointment_app_with_laravel_backend/screens/booking_page.dart';
import 'package:doctor_appointment_app_with_laravel_backend/screens/doctor_details.dart';
import 'package:doctor_appointment_app_with_laravel_backend/screens/success_booked.dart';
import 'package:doctor_appointment_app_with_laravel_backend/utils/config.dart';
import 'package:doctor_appointment_app_with_laravel_backend/utils/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

//this is for push navigator
  static final navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // define ThemeData here
    return ChangeNotifierProvider<AuthModel>(
      create: (context) => AuthModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'Flutter Doctor App',
        theme: ThemeData(
          // pre-define input decoration
          inputDecorationTheme: const InputDecorationTheme(
            focusColor: Config.primaryColor,
            border: Config.outlinedBorder,
            focusedBorder: Config.focusBorder,
            errorBorder: Config.errorBorder,
            enabledBorder: Config.outlinedBorder,
            floatingLabelStyle: TextStyle(color: Config.primaryColor),
            prefixIconColor: Colors.black38,
          ),
          scaffoldBackgroundColor: Colors.white,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Config.primaryColor,
            selectedItemColor: Colors.white,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            unselectedItemColor: Colors.grey.shade700,
            elevation: 10,
            type: BottomNavigationBarType.fixed,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          //this is initial route of the app
          // which is auth page (login and signup)
          '/': (context) => const AuthPage(),
          'main': (context) => const MainLayout(),
          'doctor_details': (context) => const DoctorDetails(),
          'booking_page': (context) => BookingPage(),
          'success_booked': (context) => const AppointmentBooked(),
        },
      ),
    );
  }
}

// now we will login component
// and page wiew
