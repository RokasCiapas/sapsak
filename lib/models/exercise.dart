import 'package:cloud_firestore/cloud_firestore.dart';

class Exercise {
  final String muscleGroup;
  final String name;
  final int repCount;
  final int setCount;
  final String id;
  final String supersetWidth;

  const Exercise({
    required this.muscleGroup,
    required this.name,
    required this.repCount,
    required this.setCount,
    required this.id,
    required this.supersetWidth,
  });

  factory Exercise.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {

    final data = snapshot.data();
    return Exercise(
      muscleGroup: data?['muscleGroup'],
      name: data?['name'],
      repCount: data?['repCount'],
      setCount: data?['setCount'],
      id: data?['id'],
      supersetWidth: data?['supersetWidth'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "muscleGroup": muscleGroup,
      "name": name,
      "repCount": repCount,
      "setCount": setCount,
    };
  }

  static Exercise fromJson(Map<String, dynamic> json) {
    return Exercise(
      muscleGroup: json['muscleGroup'],
      name: json['name'],
      repCount: json['repCount'],
      setCount: json['setCount'],
      id: json['id'],
      supersetWidth: json['supersetWidth'],
    );
  }

}