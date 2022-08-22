import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sapsak/models/exercise.dart';

class SportsDay {
  List<Exercise> exercises;

  SportsDay({
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

  static SportsDay fromJson(Map<String, dynamic> json) {
    var test = SportsDay(
        exercises: json['exercises'].map((exercise) => Exercise.fromJson(exercise)).toList()
    );
    return test;
  }
}