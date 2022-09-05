import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sapsak/services/coach_service.dart';

import '../models/coach.dart';

class CoachProvider with ChangeNotifier, DiagnosticableTreeMixin {
  final Stream<DocumentSnapshot<Coach>> _coach = CoachService().getCoachById('hn4ZKlsDwcazhJ4i8CXAGzw2Loq2');

  Stream<DocumentSnapshot<Coach>> get coach => _coach;
}