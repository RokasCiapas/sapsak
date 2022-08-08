import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sapsak/models/sports_plan.dart';

class SportsPlanService {

  final FirebaseFirestore db = FirebaseFirestore.instance;
  final CollectionReference<SportsPlan> collection = FirebaseFirestore.instance.collection('sportsPlans')
      .withConverter(
      fromFirestore: SportsPlan.fromFirestore,
      toFirestore: (SportsPlan sportsPlan, SetOptions? options) =>
          sportsPlan.toFirestore()
  );

  Future<void> addSportsPlan(SportsPlan sportsPlan) {
    return collection.add(sportsPlan);
  }

  Stream<QuerySnapshot<SportsPlan>> sportsPlanStream() {
    return collection.snapshots();
  }

}