import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sapsak/models/exercise.dart';

import 'exercise.dart';

class Multiset {
  List<Exercise> multiset;

  Multiset({
    required this.multiset,
  });

  factory Multiset.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {

    final data = snapshot.data();
    return Multiset(
      multiset: data?['multiset'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "multiset": multiset.map((Exercise e) => e.toFirestore()),
    };
  }

  static Multiset fromJson(Map<String, dynamic> json) {
    return Multiset(
      multiset: json['multiset'].map((x) => Exercise.fromJson(x)).toList(),
    );
  }

}