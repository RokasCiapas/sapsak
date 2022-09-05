import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/coach.dart';
import 'coach_service.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  User? get currentUser => auth.currentUser;

  Future<bool> isCoach() async {
    String? currentUserId = auth.currentUser?.uid;
    Stream<DocumentSnapshot<Coach>> coach = CoachService().getCoachById(currentUserId!);
    bool isCoach = false;
    await coach.first.then((value) => isCoach = value.data() != null);
    return isCoach;
  }
}