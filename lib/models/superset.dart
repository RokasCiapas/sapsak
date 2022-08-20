import 'package:cloud_firestore/cloud_firestore.dart';
import 'exercise.dart';

class Superset {
  final List<Exercise> superset;

  Superset(this.superset);

  factory Superset.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {

    final data = snapshot.data();
    return Superset(data?['superset']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "superset": superset,
    };
  }

}