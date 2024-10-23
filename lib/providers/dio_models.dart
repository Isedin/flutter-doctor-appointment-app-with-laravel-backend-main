// final temp = {
//   id: 20,
//   name: Andreas,
//   type: doctor,
//   email: andreas@email.com,
//   email_verified_at: null,
//   two_factor_confirmed_at: null,
//   current_team_id: null,
//   profile_photo_path: profile-photos/VU3VUtTxhqVGwbykEDr0g6L53MT1ezqUrYDuHNLR.jpg,
//   created_at: 2024-09-26T10:50:46.000000Z,
//   updated_at: 2024-09-26T12:11:53.000000Z,
//   doctor: [
//     {
//       id: 4,
//       doc_id: 19,
//       category: Neurochirurgie,
//       patients: 120,
//       experience: 3,
//       bio_data: I am Neurochirutgie specialist,
//       status: active,
//       created_at: 2024-09-26T10:48:49.000000Z,
//       updated_at: 2024-09-26T10:49:53.000000Z,
//       doctor_name: Isedin,
//       doctor_profile: /storage/profile-photos/jl3jjbw16sJdlO0e9GCb57txzphlUMNNLJRHolxY.jpg
//     },
//   ],
//   details: null,
//   profile_photo_url: /storage/profile-photos/VU3VUtTxhqVGwbykEDr0g6L53MT1ezqUrYDuHNLR.jpg, user_details: null
// }

class UserModel {
  final int id;
  final String name;
  final String type;
  final String email;
  final DateTime? emailVerifiedAt;
  // final DateTime? twoFactorConfirmedAt;
  final int? currentTeamId;
  final String? profilePhotoPath;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final List<DoctorModel> doctors;
  final UserDetails? details;

  UserModel({
    required this.id,
    required this.name,
    required this.type,
    required this.email,
    this.emailVerifiedAt,
    //  this.twoFactorConfirmedAt,
    this.currentTeamId,
    required this.profilePhotoPath,
    required this.createdAt,
    this.updatedAt,
    required this.doctors,
    this.details,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      // twoFactorConfirmedAt: json['two_factor_confirmed_at'],
      currentTeamId: json['current_team_id'],
      profilePhotoPath: json['profile_photo_path'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      doctors: List<DoctorModel>.from(json['doctor'].map((x) => DoctorModel.fromJson(x))),
      details: json['details'] != null ? UserDetails.fromJson(json['details']) : null,
    );
  }
}

// {
//       id: 4,
//       doc_id: 19,
//       category: Neurochirurgie,
//       patients: 120,
//       experience: 3,
//       bio_data: I am Neurochirutgie specialist,
//       status: active,
//       created_at: 2024-09-26T10:48:49.000000Z,
//       updated_at: 2024-09-26T10:49:53.000000Z,
//       doctor_name: Isedin,
//       doctor_profile: /storage/profile-photos/jl3jjbw16sJdlO0e9GCb57txzphlUMNNLJRHolxY.jpg
//     },

class DoctorModel {
  final int id;
  final int docId;
  final String category;
  final int patients;
  final int experience;
  final String bioData;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String doctorName;
  final String doctorProfile;
  final Appointment? appointment;

  DoctorModel({
    required this.id,
    required this.docId,
    required this.category,
    required this.patients,
    required this.experience,
    required this.bioData,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.doctorName,
    required this.doctorProfile,
    this.appointment,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'],
      docId: json['doc_id'],
      category: json['category'],
      patients: json['patients'],
      experience: json['experience'],
      bioData: json['bio_data'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      doctorName: json['doctor_name'],
      doctorProfile: json['doctor_profile'],
      appointment:
          json['appointment'] == null ? null : Appointment.fromJson(json['appointment'] as Map<String, dynamic>),
    );
  }
}

class Appointment {
  final int id;
  final String date;
  final String day;
  final String time;
  final int doctorId;

  Appointment({
    required this.id,
    required this.date,
    required this.day,
    required this.time,
    required this.doctorId,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      date: json['date'],
      day: json['day'],
      time: json['time'],
      doctorId: json['doctor_id'],
    );
  }
}

class UserDetails {
  final List<int> fav;

  UserDetails({
    this.fav = const [],
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      fav: json['fav'] == null ? [] : json['fav'],
    );
  }
}
