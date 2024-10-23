import 'package:doctor_appointment_app_with_laravel_backend/main.dart';
import 'package:doctor_appointment_app_with_laravel_backend/providers/dio_models.dart';
import 'package:doctor_appointment_app_with_laravel_backend/screens/doctor_details.dart';
import 'package:doctor_appointment_app_with_laravel_backend/utils/config.dart';
import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({Key? key, this.doctor, required this.isFav}) : super(key: key);

  final DoctorModel? doctor; //receive doctor details
  final bool isFav;

  @override
  Widget build(BuildContext context) {
    Config.init(context);
    return doctor == null
        ? Container(
            child: Text('No doctor information available'),
          )
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: 150,
            child: GestureDetector(
              child: Card(
                elevation: 5,
                color: Colors.white,
                child: Row(
                  children: [
                    SizedBox(
                      width: Config.widthSize * 0.33,
                      child: Image.network(
                        "http://127.0.0.1:8000${doctor!.doctorProfile}",
                        fit: BoxFit.fill,
                      ),
                    ),
                    // ignore: prefer_const_constructors
                    Flexible(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Dr. ${doctor!.doctorName}',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${doctor!.category}',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                          ),
                          const Spacer(),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.star_border,
                                color: Colors.yellow,
                                size: 16,
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              Text('4.5'),
                              Spacer(
                                flex: 1,
                              ),
                              Text('Reviews'),
                              Spacer(
                                flex: 1,
                              ),
                              Text('(20)'),
                              Spacer(
                                flex: 7,
                              ),
                            ],
                          )
                        ],
                      ),
                    ))
                  ],
                ),
              ),
              onTap: () {
                //pass doctor details to doctor detail page
                // Navigator.of(context).pushNamed(route, arguments: doctor);
                MyApp.navigatorKey.currentState!.push(MaterialPageRoute(
                    builder: (_) => DoctorDetails(
                          doctor: doctor!,
                          isFav: isFav,
                        )));
              }, // navigate to doctor detail page
            ),
          );
  }
}
