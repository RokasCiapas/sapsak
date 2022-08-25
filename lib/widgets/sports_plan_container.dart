import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapsak/providers/sports_plan_list_provider.dart';
import 'package:supercharged/supercharged.dart';

import '../models/exercise.dart';
import '../models/sports_day.dart';
import '../models/sports_plan.dart';
import 'exercise_list.dart';

class SportsPlanContainer extends StatelessWidget {
  const SportsPlanContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SportsPlan sportsPlan = context.watch<SportsPlanProvider>().selectedSportsPlan;

    return ListView.builder(
      shrinkWrap: true,
      itemCount: sportsPlan.sportsDays.length,
      itemBuilder: (BuildContext context,
          int sportsDayIndex) {
        SportsDay sportsDay = sportsPlan
            .sportsDays[sportsDayIndex];
        return Column(
          children: [
            SizedBox(
              height: 60,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Day ${sportsDayIndex + 1}',
                      style:
                      const TextStyle(
                          fontSize: 18))),
            ),
            Card(
              child: ExerciseList(
                sportsDay: sportsDay,
                addExerciseToMultiset: (int multisetIndex) {
                  _addExerciseToMultiset(sportsDayIndex, multisetIndex, sportsPlan, context);
                },
                changeMuscleGroup: (int multisetIndex, int exerciseIndex, Exercise exercise, String? newValue) {
                  _changeMuscleGroup(sportsDayIndex, multisetIndex, sportsPlan, exercise, exerciseIndex, newValue, context);
                },
                changeExercise: (int multisetIndex, int exerciseIndex, Exercise exercise, String? newValue) {
                  _changeExercise(sportsDayIndex, multisetIndex, sportsPlan, exercise, exerciseIndex, newValue, context);
                },
                changeSetCount: (int multisetIndex, int exerciseIndex, Exercise exercise, String? newValue) {
                  _changeSetCount(sportsDayIndex, multisetIndex, sportsPlan, exercise, exerciseIndex, newValue, context);
                },
                changeRepCount: (int multisetIndex, int exerciseIndex, Exercise exercise, String? newValue) {
                  _changeRepCount(sportsDayIndex, multisetIndex, sportsPlan, exercise, exerciseIndex, newValue, context);
                },
              ),
            )
          ],
        );
      },
    );
  }

  void _addExerciseToMultiset(int sportsDayIndex, int multisetIndex, SportsPlan sportsPlan, BuildContext context) {
    SportsPlan newSportsPlan = sportsPlan;
    newSportsPlan.sportsDays[sportsDayIndex].multisets[multisetIndex]?.multiset.add(
        const Exercise(muscleGroup: 'Shoulders', name: '', repCount: 0, setCount: 0)
    );
    context.read<SportsPlanProvider>().setSelectedSportsPlan(newSportsPlan);
  }

  void _changeMuscleGroup(int sportsDayIndex, int multisetIndex, SportsPlan sportsPlan, Exercise exercise, int exerciseIndex, String? newValue, BuildContext context) {
    SportsPlan newSportsPlan = sportsPlan;
    newSportsPlan.sportsDays[sportsDayIndex].multisets[multisetIndex]?.multiset[exerciseIndex] = Exercise(
        muscleGroup: newValue!,
        name: exercise.name,
        repCount: exercise.repCount,
        setCount: exercise.setCount
    );

    context.read<SportsPlanProvider>().setSelectedSportsPlan(newSportsPlan);
  }

  void _changeExercise(int sportsDayIndex, int multisetIndex, SportsPlan sportsPlan, Exercise exercise, int exerciseIndex, String? newValue, BuildContext context) {
    SportsPlan newSportsPlan = sportsPlan;
    newSportsPlan.sportsDays[sportsDayIndex].multisets[multisetIndex]?.multiset[exerciseIndex] = Exercise(
        muscleGroup: exercise.muscleGroup,
        name: newValue!,
        repCount: exercise.repCount,
        setCount: exercise.setCount
    );

    context.read<SportsPlanProvider>().setSelectedSportsPlan(newSportsPlan);
  }

  void _changeSetCount(int sportsDayIndex, int multisetIndex, SportsPlan sportsPlan, Exercise exercise, int exerciseIndex, String? newValue, BuildContext context) {
    SportsPlan newSportsPlan = sportsPlan;
    newSportsPlan.sportsDays[sportsDayIndex].multisets[multisetIndex]?.multiset[exerciseIndex] = Exercise(
        muscleGroup: exercise.muscleGroup,
        name: exercise.name,
        repCount: exercise.repCount,
        setCount: int.parse(newValue!)
    );

    context.read<SportsPlanProvider>().setSelectedSportsPlan(newSportsPlan);
  }

  void _changeRepCount(int sportsDayIndex, int multisetIndex, SportsPlan sportsPlan, Exercise exercise, int exerciseIndex, String? newValue, BuildContext context) {
    SportsPlan newSportsPlan = sportsPlan;
    newSportsPlan.sportsDays[sportsDayIndex].multisets[multisetIndex]?.multiset[exerciseIndex] = Exercise(
        muscleGroup: exercise.muscleGroup,
        name: exercise.name,
        repCount: int.parse(newValue!),
        setCount: exercise.repCount
    );

    context.read<SportsPlanProvider>().setSelectedSportsPlan(newSportsPlan);
  }
}
