import 'package:doctor_appointment_app_with_laravel_backend/components/doctor_card.dart';
import 'package:doctor_appointment_app_with_laravel_backend/models/auth_model.dart';
import 'package:doctor_appointment_app_with_laravel_backend/providers/dio_models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key,  this.doctor});
  final DoctorModel? doctor;

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: [
            const Text(
              'My Favorite Doctors',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Consumer<AuthModel>(
                builder: (context, auth, child) => ListView.builder(
                  itemCount: auth.getFavDoc.length,
                  itemBuilder: (context, index) => DoctorCard(
                    doctor: null, //auth.getFavDoc[index]
                    isFav: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
