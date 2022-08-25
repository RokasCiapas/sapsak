import 'package:cloud_firestore/cloud_firestore.dart';

import 'multiset.dart';

class SportsDay {
  Map<int, Multiset> multisets;

  SportsDay({
    required this.multisets
  });

  factory SportsDay.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {

    final data = snapshot.data();

    return SportsDay(
        multisets: Map.from(data?['multiset'])
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "multisets": multisets.map((key, value) => MapEntry(key, value.toFirestore())),
    };
  }

  static SportsDay fromJson(Map<String, dynamic> json) {
    var test = SportsDay(
        multisets: json['multisets'].map((multiset) => Multiset.fromJson(multiset)).toList()
    );
    return test;
  }
}