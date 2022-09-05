import 'package:cloud_firestore/cloud_firestore.dart';

class Coach {
  final Timestamp firstLogin;
  final String name;
  final String surname;
  final String email;
  final String phoneNumber;

  Coach({
    required this.firstLogin,
    required this.name,
    required this.surname,
    required this.email,
    required this.phoneNumber,
  });

  factory Coach.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Coach(
      firstLogin: data?['firstLogin'],
      name: data?['name'],
      surname: data?['surname'],
      email: data?['email'],
      phoneNumber: data?['phoneNumber'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "firstLogin": firstLogin,
      "name": name,
      "surname": surname,
      "email": email,
      "phoneNumber": phoneNumber,
    };
  }
}
