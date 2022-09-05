import 'package:cloud_firestore/cloud_firestore.dart';

class Exercise {
  final String muscleGroup;
  final String name;
  final int repCount;
  final int setCount;
  final String weight;

  const Exercise({
    required this.muscleGroup,
    required this.name,
    required this.repCount,
    required this.setCount,
    required this.weight,
  });

  factory Exercise.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {

    final data = snapshot.data();
    return Exercise(
      muscleGroup: data?['muscleGroup'],
      name: data?['name'],
      repCount: data?['repCount'],
      setCount: data?['setCount'],
      weight: data?['weight'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "muscleGroup": muscleGroup,
      "name": name,
      "repCount": repCount,
      "setCount": setCount,
      "weight": weight,
    };
  }

  static Exercise fromJson(dynamic json) {
    return Exercise(
        muscleGroup: json['muscleGroup'],
        name: json['name'],
        repCount: json['repCount'],
        setCount: json['setCount'],
        weight: json['weight']
    );
  }

}