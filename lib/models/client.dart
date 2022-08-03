import 'package:cloud_firestore/cloud_firestore.dart';

class Client {
  final Timestamp firstLogin;
  final String name;
  final String surname;
  final String email;
  final int phoneNumber;
  final Timestamp birthday;
  final bool acceptMarketing;
  final String? healthIssues;
  final String? whereDidYouGetInfo;

  Client({
    required this.firstLogin,
    required this.name,
    required this.surname,
    required this.email,
    required this.phoneNumber,
    required this.birthday,
    required this.acceptMarketing,
    this.healthIssues,
    this.whereDidYouGetInfo,
  });

  factory Client.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Client(
        firstLogin: data?['firstLogin'],
        name: data?['name'],
        surname: data?['surname'],
        email: data?['email'],
        phoneNumber: data?['phoneNumber'],
        birthday: data?['birthday'],
        acceptMarketing: data?['acceptMarketing'],
        healthIssues: data?['healthIssues'],
        whereDidYouGetInfo: data?['whereDidYouGetInfo']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "firstLogin": firstLogin,
      "name": name,
      "surname": surname,
      "email": email,
      "phoneNumber": phoneNumber,
      "birthday": birthday,
      "acceptMarketing": acceptMarketing,
      "whereDidYouGetInfo": whereDidYouGetInfo,
    };
  }
}
