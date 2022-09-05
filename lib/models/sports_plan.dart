import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sapsak/models/exercise.dart';
import 'package:sapsak/models/sports_day.dart';

class SportsPlan {
  final List<SportsDay> sportsDays;
  final String ownerEmail;
  final Timestamp? createdAt;
  final Timestamp? bestUntil;
  final String notes;
  final String goal;
  final bool isDraft;
  final String id;

  SportsPlan({
    required this.sportsDays,
    required this.ownerEmail,
    this.createdAt,
    this.bestUntil,
    required this.notes,
    required this.goal,
    required this.isDraft,
    required this.id,
  });

  factory SportsPlan.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {

    final data = snapshot.data();
    return SportsPlan(
      sportsDays: List.from((data?['sportsDays']).map((e) =>
          SportsDay(
              multisets: Map.from((e['multiset']).map((x) =>
                  Exercise(
                    muscleGroup: x['muscleGroup'],
                    name: x['name'],
                    repCount: x['repCount'],
                    setCount: x['setCount'],
                    weight: x['weight'],
                  )
              ))
          )
      )),
      ownerEmail: data?['ownerEmail'] ?? '',
      createdAt: data?['createdAt'] ?? Timestamp.fromDate(DateTime.now()),
      bestUntil: data?['bestUntil'] ?? Timestamp.fromDate(DateTime.now()),
      notes: data?['notes'] ?? '',
      goal: data?['goal'] ?? '',
      isDraft: data?['isDraft'] ?? false,
      id: data?['id'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "sportsDays": sportsDays.map((SportsDay sportsDay) => sportsDay.toFirestore()),
      "ownerEmail": ownerEmail,
      "createdAt": createdAt,
      "bestUntil": bestUntil,
      "notes": notes,
      "goal": goal,
      "isDraft": isDraft,
      "id": id,
    };
  }

  static SportsPlan fromJson(QueryDocumentSnapshot json) {
    var sp = SportsPlan(
      id: json.id,
      sportsDays: List.from(json.get('sportsDays').map((dynamic day) => SportsDay.fromJson(day['multisets']))),
      ownerEmail: json.get('ownerEmail') ?? '',
      notes: json.get('notes') ?? '',
      goal: json.get('goal') ?? '',
      isDraft: json.get('isDraft') ?? false,
      createdAt: json.get('createdAt'),
      bestUntil: json.get('bestUntil'),
    );

    return sp;
  }
}
