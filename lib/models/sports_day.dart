import 'package:cloud_firestore/cloud_firestore.dart';

import 'exercise.dart';

class SportsDay {
  final List<Exercise> exercises;

  const SportsDay({
    required this.exercises
  });

  factory SportsDay.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {

    final data = snapshot.data();

    return SportsDay(
        exercises: List.from(data?['exercises'])
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "exercises": exercises.map((e) => e.toFirestore()),
    };
  }
}