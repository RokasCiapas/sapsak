import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sapsak/models/exercise.dart';
import 'package:sapsak/models/sports_day.dart';
import 'dart:convert';

class SportsPlan {
  final List<SportsDay> sportsDays;
  final String ownerUid;
  final Timestamp createdAt;
  final Timestamp bestUntil;
  final String notes;
  final bool isDraft;

  SportsPlan({
    required this.sportsDays,
    required this.ownerUid,
    required this.createdAt,
    required this.bestUntil,
    required this.notes,
    required this.isDraft,
  });

  factory SportsPlan.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {

    final data = snapshot.data();
    return SportsPlan(
      sportsDays: List.from((data?['sportsDays']).map((e) =>
          SportsDay(
              exercises: List.from((e['exercises']).map((x) =>
                  Exercise(
                      muscleGroup: x['muscleGroup'],
                      name: x['name'],
                      repCount: x['repCount'],
                      setCount: x['setCount']
                  )
              ))
          )
      )),
      ownerUid: data?['ownerUid'] ?? '',
      createdAt: data?['createdAt'] ?? Timestamp.fromDate(DateTime.now()),
      bestUntil: data?['bestUntil'] ?? Timestamp.fromDate(DateTime.now()),
      notes: data?['notes'] ?? '',
      isDraft: data?['isDraft'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "sportsDays": sportsDays.map((e) => e.toFirestore()),
      "ownerUid": ownerUid,
      "createdAt": createdAt,
      "bestUntil": bestUntil,
      "notes": notes,
      "isDraft": isDraft,
    };
  }
}