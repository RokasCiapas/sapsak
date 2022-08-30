import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sapsak/models/multiset.dart';
import 'package:sapsak/models/sports_plan.dart';
import 'package:sapsak/providers/client_provider.dart';
import 'package:uuid/uuid.dart';

import '../models/client.dart';
import '../models/exercise.dart';
import '../models/sports_day.dart';
import '../services/sports_plan_service.dart';

class SportsPlanProvider with ChangeNotifier, DiagnosticableTreeMixin {

  SportsPlanProvider({required ClientProvider clientProvider})
      : _clientProvider = clientProvider;

  final ClientProvider _clientProvider;

  final Client? client = ClientProvider().selectedClient;

  SportsPlan selectedSportsPlan = SportsPlan(
      sportsDays: List.filled(
          1,
          SportsDay(
              multisets: {
                0: Multiset(
                    multiset: List.filled(1, const Exercise(muscleGroup: 'Shoulders', name: '', repCount: 0, setCount: 0, weight: ''), growable: true)
                )
              }),
        growable: true
      ),
      ownerEmail: '',
      createdAt: null,
      bestUntil: null,
      notes: '',
      goal: '',
      isDraft: true,
      id: const Uuid().v1()
  );

  Stream<QuerySnapshot<SportsPlan>> get sportsPlanListByUser {
    return SportsPlanService().sportsPlanByUserStream(_clientProvider.selectedClient?.email);
  }

  Stream<List<SportsPlan>> getAllSportsPlans() {
    return SportsPlanService().getAllSportsPlans();
  }

  void setSelectedSportsPlan(SportsPlan sportsPlan) {
    selectedSportsPlan = sportsPlan;
    notifyListeners();
  }

  void resetSelectedSportsPlan() {
    setSelectedSportsPlan(
        SportsPlan(
            sportsDays: List.filled(
                1,
                SportsDay(
                    multisets: {
                      0: Multiset(
                          multiset: List.filled(1, const Exercise(muscleGroup: 'Shoulders', name: '', repCount: 0, setCount: 0, weight: ''), growable: true)
                      )
                    }),
                growable: true
            ),
            ownerEmail: '',
            createdAt: null,
            bestUntil: null,
            notes: '',
            goal: '',
            isDraft: true,
            id: const Uuid().v1()
        )
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    // properties.add(IntProperty('count', count));
  }
}