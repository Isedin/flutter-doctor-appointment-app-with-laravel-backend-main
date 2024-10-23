// import 'package:dio/dio.dart';
import 'dart:developer';

import 'package:doctor_appointment_app_with_laravel_backend/main.dart';
import 'package:doctor_appointment_app_with_laravel_backend/providers/dio_models.dart';
import 'package:doctor_appointment_app_with_laravel_backend/providers/dio_provider.dart';
import 'package:doctor_appointment_app_with_laravel_backend/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentCard extends StatefulWidget {
  const AppointmentCard({super.key, required this.doctor, required this.color});

  final DoctorModel? doctor;
  final Color color;

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  @override
  Widget build(BuildContext context) {
    log('doctor auf Appointment Card: ${widget.doctor}');
    // print('appointments: ${widget.doctor!['appointment']}');
    // Check if doctor is null and provide a default UI or message
    if (widget.doctor == null || (widget.doctor as Map).isEmpty) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'No doctor information available',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage("http://127.0.0.1:8000${widget.doctor!.doctorProfile}"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Dr. ${widget.doctor?.doctorName ?? 'Unknown Doctor'}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        widget.doctor?.category ?? 'Unknown Category',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
              Config.spaceSmall,
              // Schedule information
              ScheduleCard(
                appointment : widget.doctor?.appointment ,
              ),
              Config.spaceSmall,
              // action button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return RatingDialog(
                              initialRating: 1.0,
                              title: const Text(
                                'Rate the Doctor',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              message: const Text(
                                'Please help us to rate our Doctor',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              image: const FlutterLogo(
                                size: 100,
                              ),
                              submitButtonText: 'Submit',
                              commentHint: 'Your Reviews',
                              onSubmitted: (response) async {
                                final SharedPreferences prefs = await SharedPreferences.getInstance();
                                final token = prefs.getString('token') ?? '';

                                try {
                                  final rating = await DioProvider().storeReviews(
                                      response.comment,
                                      response.rating,
                                      widget.doctor!.appointment!.id, // this is appointment id
                                      widget.doctor!.docId, // this is doctor id
                                      token);

                                  if (rating == 200) {
                                    // if successful, refresh
                                    MyApp.navigatorKey.currentState!.pushNamed('main');
                                  } else {
                                    // Handle errors (e.g., show a snackbar or dialog)
                                  }
                                } catch (e) {
                                  // Handle Dio or network exceptions
                                  print('Error: $e');
                                }
                              },
                            );
                          },
                        );
                      },
                      child: const Text(
                        'Completed',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
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

// Schedule Widget
class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key, required this.appointment});
  final Appointment? appointment;

  @override
  Widget build(BuildContext context) {
    // Check if appointment is null and show an empty container
    // if (appointment is! DioException) {
    //   return Container(
    //     padding: const EdgeInsets.all(20),
    //     child: const Text(
    //       "No appointment details available",
    //       style: TextStyle(color: Colors.white),
    //     ),
    //   );
    // }
    log('appointment: $appointment');
    if (appointment == null) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: const Text(
          "No appointment details available",
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.calendar_today,
            color: Colors.white,
            size: 15,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            '${appointment!.day}, ${appointment!.date}',
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            width: 10,
          ),
          const Icon(
            Icons.access_alarm,
            color: Colors.white,
            size: 17,
          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
              child: Text(
            appointment!.time,
            style: const TextStyle(
              color: Colors.white,
            ),
          ))
        ],
      ),
    );
  }
}
