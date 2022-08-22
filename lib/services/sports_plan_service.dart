import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sapsak/models/sports_plan.dart';

class SportsPlanService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final CollectionReference<SportsPlan> collection = FirebaseFirestore.instance
      .collection('sportsPlans')
      .withConverter(
          fromFirestore: SportsPlan.fromFirestore,
          toFirestore: (SportsPlan sportsPlan, SetOptions? options) =>
              sportsPlan.toFirestore());

  Future<DocumentReference<SportsPlan>> addSportsPlan(SportsPlan sportsPlan) {
    return collection.add(sportsPlan);
  }

  Future<void> editSportsPlan(SportsPlan sportsPlan, String sportsPlanId) {
    return collection.doc(sportsPlanId).update(sportsPlan.toFirestore());
  }

  Stream<QuerySnapshot<SportsPlan>> sportsPlanByUserStream(String? email) {
    return collection
        .where('ownerEmail', isEqualTo: email)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Stream<List<SportsPlan>> getAllSportsPlans() {
    return FirebaseFirestore.instance
        .collection('sportsPlans')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        var sportsPlan = SportsPlan.fromJson(doc);
        return sportsPlan;
      }).toList();
    });
  }
}
