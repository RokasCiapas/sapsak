import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/coach.dart';

class CoachService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final CollectionReference<Coach> collection = FirebaseFirestore.instance.collection('coaches')
      .withConverter(
      fromFirestore: Coach.fromFirestore,
      toFirestore: (Coach coach, options) =>
          coach.toFirestore()
  );

  Stream<DocumentSnapshot<Coach>> getCoachById(String id) {
    return collection.doc(id).snapshots();
  }

  Future<void> addCoach(String uid, Coach coach) {
    return collection.doc(uid).set(coach);
  }


}