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
                    multiset: List.filled(1, const Exercise(muscleGroup: 'Shoulders', name: '', repCount: '', setCount: 0, weight: ''), growable: true)
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

  Stream<List<SportsPlan>> get sportsPlanListByOwner {
    return SportsPlanService().sportsPlanListByOwnerStream(_clientProvider.selectedClient?.email);
  }

  Stream<List<SportsPlan>> getAllSportsPlansForOwner(String email) {
    return SportsPlanService().getAllSportsPlansForOwner(email);
  }

  Stream<List<SportsPlan>> getAllSportsPlans() {
    return SportsPlanService().getAllSportsPlans();
  }

  void setSelectedSportsPlan(SportsPlan sportsPlan) {
    selectedSportsPlan = sportsPlan;
    notifyListeners();
  }

  void addMultiset(int sportsDayIndex) {
    if (selectedSportsPlan.sportsDays[sportsDayIndex].multisets.isNotEmpty) {
      int lastKey = selectedSportsPlan.sportsDays[sportsDayIndex].multisets.keys.last;

      selectedSportsPlan.sportsDays[sportsDayIndex].multisets[lastKey + 1] = Multiset(multiset: [
        const Exercise(
            muscleGroup: 'Shoulders',
            name: '',
            repCount: '',
            setCount: 0,
            weight: ''
        )]);
    } else {
      selectedSportsPlan.sportsDays[sportsDayIndex].multisets[0] = Multiset(multiset: [
        const Exercise(
            muscleGroup: 'Shoulders',
            name: '',
            repCount: '',
            setCount: 0,
            weight: ''
        )]);
    }
    notifyListeners();
  }

  void addExerciseToMultiset(int sportsDayIndex, int multisetIndex) {

    selectedSportsPlan.sportsDays[sportsDayIndex].multisets[multisetIndex]!.multiset
        .add(
        const Exercise(muscleGroup: 'Shoulders',
            name: '',
            repCount: '',
            setCount: 0,
            weight: '')
    );
    notifyListeners();
  }

  void removeExercise(int sportsDayIndex, int multisetIndex, int exerciseIndex) {
    selectedSportsPlan.sportsDays[sportsDayIndex].multisets[multisetIndex]?.multiset.removeAt(exerciseIndex);
    notifyListeners();
  }

  void removeMultiset(int sportsDayIndex, int multisetIndex) {
    selectedSportsPlan.sportsDays[sportsDayIndex].multisets.remove(multisetIndex);
    notifyListeners();
  }

  void removeDay(int sportsDayIndex) {
    selectedSportsPlan.sportsDays.removeAt(sportsDayIndex);
    notifyListeners();
  }

  void changeExercise(int sportsDayIndex, int multisetIndex, Exercise exercise, int exerciseIndex, String? newValue) {
    selectedSportsPlan.sportsDays[sportsDayIndex].multisets[multisetIndex]
        ?.multiset[exerciseIndex] = Exercise(
        muscleGroup: exercise.muscleGroup,
        name: newValue!,
        repCount: exercise.repCount,
        setCount: exercise.setCount,
        weight: exercise.weight
    );
    notifyListeners();

  }

  void changeSetCount(int sportsDayIndex, int multisetIndex, Exercise exercise, int exerciseIndex, String? newValue) {
    selectedSportsPlan.sportsDays[sportsDayIndex].multisets[multisetIndex]
        ?.multiset[exerciseIndex] = Exercise(
        muscleGroup: exercise.muscleGroup,
        name: exercise.name,
        repCount: exercise.repCount,
        setCount: newValue!.isNotEmpty ? int.parse(newValue) : 0,
        weight: exercise.weight
    );
    notifyListeners();
  }

  void changeRepCount(int sportsDayIndex, int multisetIndex, Exercise exercise, int exerciseIndex, String? newValue) {
    selectedSportsPlan.sportsDays[sportsDayIndex].multisets[multisetIndex]
        ?.multiset[exerciseIndex] = Exercise(
        muscleGroup: exercise.muscleGroup,
        name: exercise.name,
        repCount: newValue!.isNotEmpty ? newValue : '',
        setCount: exercise.setCount,
        weight: exercise.weight
    );
    notifyListeners();
  }

  void changeWeight(int sportsDayIndex, int multisetIndex, Exercise exercise, int exerciseIndex, String? newValue) {
    selectedSportsPlan.sportsDays[sportsDayIndex].multisets[multisetIndex]
        ?.multiset[exerciseIndex] = Exercise(
        muscleGroup: exercise.muscleGroup,
        name: exercise.name,
        repCount: exercise.repCount,
        setCount: exercise.setCount,
        weight: newValue!
    );

    notifyListeners();
  }

  void changeMuscleGroup(int sportsDayIndex, int multisetIndex, Exercise exercise, int exerciseIndex, String? newValue) {
    selectedSportsPlan.sportsDays[sportsDayIndex].multisets[multisetIndex]
        ?.multiset[exerciseIndex] = Exercise(
        muscleGroup: newValue!,
        name: exercise.name,
        repCount: exercise.repCount,
        setCount: exercise.setCount,
        weight: ''
    );
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
                          multiset: List.filled(1, const Exercise(muscleGroup: 'Shoulders', name: '', repCount: '', setCount: 0, weight: ''), growable: true)
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
    properties.add(ObjectFlagProperty('selectedSportsPlan', selectedSportsPlan));
  }
}