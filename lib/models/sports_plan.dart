import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sapsak/models/sports_day.dart';

class SportsPlan {
  final List<SportsDay> sportsDays;
  final String ownerUid;

  SportsPlan({
    required this.sportsDays,
    required this.ownerUid,
  });

  factory SportsPlan.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {

    final data = snapshot.data();
    return SportsPlan(
      sportsDays: data?['sportsDays'],
      ownerUid: data?['ownerUid'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "sportsDays": sportsDays.map((e) => e.toFirestore()),
      "ownerUid": ownerUid,
    };
  }
}