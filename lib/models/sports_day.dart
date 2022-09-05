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
      "multisets": multisets.map((key, Multiset multiset) => MapEntry(key, multiset.toFirestore())),
    };
  }

  static SportsDay fromJson(Map<String, dynamic> json) {
    var test = SportsDay(
        multisets: json.map((String key, dynamic value) => MapEntry(int.parse(key), Multiset.fromJson(value['multiset'])))
    );
    return test;
  }
}