import 'exercise.dart';

class SportsDay {
  final List<Exercise> exercises;

  SportsDay({
    required this.exercises
  });

  Map<String, dynamic> toFirestore() {
    return {
      "exercises": exercises.map((e) => e.toFirestore()),
    };
  }
}