import 'dart:developer';

import 'package:doctor_appointment_app_with_laravel_backend/components/button.dart';
import 'package:doctor_appointment_app_with_laravel_backend/models/auth_model.dart';
import 'package:doctor_appointment_app_with_laravel_backend/providers/dio_models.dart';
import 'package:doctor_appointment_app_with_laravel_backend/providers/dio_provider.dart';
// import 'package:doctor_appointment_app_with_laravel_backend/components/custom_appbar.dart';
import 'package:doctor_appointment_app_with_laravel_backend/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/custom_appbar.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({super.key, required this.doctor, required this.isFav});

  final DoctorModel doctor;
  final bool isFav;

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  bool isFav = false;

  @override
  void initState() {
    isFav = widget.isFav;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //get doctor data from doctor card
    // final doctor = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: CustomAppbar(
        appTitle: 'Doctor Details',
        icon: const FaIcon(Icons.arrow_back_ios),
        actions: [
          //Favorite button
          IconButton(
              // pressing this button adds/removes the doctor to/from favorite list
              onPressed: () async {
                //get latest favorite list from auth model
                final latestFavList = Provider.of<AuthModel>(context, listen: false).getFav;

                //if doctor is already in favorite list, remove it
                if (latestFavList.contains(widget.doctor.docId)) {
                  latestFavList.removeWhere((id) => id == widget.doctor.docId);
                } else {
                  //if doctor is not in favorite list, add it
                  latestFavList.add(widget.doctor.docId);
                }

                //update favorite list in auth model and notify all widgets
                Provider.of<AuthModel>(context, listen: false).setFavList(latestFavList);

                final SharedPreferences prefs = await SharedPreferences.getInstance();
                final token = prefs.getString('token') ?? '';

                if (token.isNotEmpty && token != '') {
                  //update favorite list in database
                  final response = await DioProvider().storeFavDoc(token, latestFavList);
                  //if response is successful, then  change the favorite status
                  if (response == 200) {
                    setState(() {
                      isFav = !isFav;
                    });
                    log('favorite list updated');
                  }
                }
              },
              icon: FaIcon(
                isFav ? Icons.favorite_rounded : Icons.favorite_outline,
                color: Colors.red,
              ))
        ],
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          //pass doctor data to about doctor widget
          AboutDoctor(
            doctor: widget.doctor,
          ),
          DetailBody(
            doctor: widget.doctor,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Button(
              width: double.infinity,
              title: 'Book Appointment',
              onPressed: () {
                //pass doctor id for booking process
                Navigator.of(context).pushNamed('booking_page', arguments: {
                  'doctor_id': widget.doctor.docId,
                  // 'doctor_name': doctor['doctor_name'],
                });
              },
              disable: false,
            ),
          )
        ],
      )),
    );
  }
}

class AboutDoctor extends StatelessWidget {
  const AboutDoctor({super.key, required this.doctor});

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    Config.init(context);
    final pictureUrl = "http://127.0.0.1:8000${doctor.doctorProfile}";
    log('pictureUrl: $pictureUrl');
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 65.0,
            backgroundImage: NetworkImage(
              pictureUrl,
            ),
            backgroundColor: Colors.white,
          ),
          Config.spaceSmall,
          Text(
            'Dr. ${doctor.doctorName}',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Config.spaceSmall,
          SizedBox(
            width: Config.widthSize * 0.75,
            child: const Text(
              'MBBS(International Medical University Malaysia), MRCP (Royal College of Physicians, London)',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          Config.spaceSmall,
          SizedBox(
            width: Config.widthSize * 0.8,
            child: const Text(
              'Sarawad, General Hospital, Malaysia',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class DetailBody extends StatelessWidget {
  const DetailBody({super.key, required this.doctor});

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    Config.init(context);
    return Container(
      padding: const EdgeInsets.all(10),
      // margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Config.spaceSmall,
          DoctorInfo(
            patients: doctor.patients,
            experience: doctor.experience,
          ),
          Config.spaceMedium,
          const Text(
            'About Doctor',
            style: TextStyle(
                // color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
          Config.spaceSmall,
          Text(
            'Dr. ${doctor.doctorName} is a ${doctor.category} in Sarawak, General Hospital, Malaysia. He has an experience of 10 years in this field. He completed MBBS from International Medical University Malaysia in 2009.',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              height: 1.5,
              color: Colors.grey,
              // fontSize: 15,
            ),
            softWrap: true,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}

class DoctorInfo extends StatelessWidget {
  const DoctorInfo({super.key, required this.patients, required this.experience});

  final int patients;
  final int experience;

  @override
  Widget build(BuildContext context) {
    // Config.init(context);
    return Row(
      children: <Widget>[
        InfoCard(
          label: 'Patients',
          value: '$patients',
        ),
        const SizedBox(
          width: 10,
        ),
        InfoCard(
          label: 'Experience',
          value: '$experience years',
        ),
        const SizedBox(
          width: 10,
        ),
        const InfoCard(
          label: 'Rating',
          value: '4.6',
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Config.primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: <Widget>[
            Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
