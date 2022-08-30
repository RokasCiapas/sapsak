import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapsak/providers/sports_plan_list_provider.dart';

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
    SportsPlan sportsPlan = context
        .watch<SportsPlanProvider>()
        .selectedSportsPlan;

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
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
            ExerciseList(
              sportsDay: sportsDay,
              addExerciseToMultiset: (int multisetIndex) {
                _addExerciseToMultiset(sportsDayIndex, multisetIndex, context);
              },
              changeMuscleGroup: (int multisetIndex, int exerciseIndex, Exercise exercise, String? newValue) {
                _changeMuscleGroup(sportsDayIndex, multisetIndex, exercise, exerciseIndex, newValue, context);
              },
              changeExercise: (int multisetIndex, int exerciseIndex, Exercise exercise, String? newValue) {
                _changeExercise(sportsDayIndex, multisetIndex, exercise, exerciseIndex, newValue, context);
              },
              changeSetCount: (int multisetIndex, int exerciseIndex, Exercise exercise, String? newValue) {
                _changeSetCount(sportsDayIndex, multisetIndex, exercise, exerciseIndex, newValue, context);
              },
              changeRepCount: (int multisetIndex, int exerciseIndex, Exercise exercise, String? newValue) {
                _changeRepCount(sportsDayIndex, multisetIndex, exercise, exerciseIndex, newValue, context);
              },
              changeWeight: (int multisetIndex, int exerciseIndex, Exercise exercise, String? newValue) {
                _changeWeight(sportsDayIndex, multisetIndex, exercise, exerciseIndex, newValue, context);
              },
              removeExercise: (int multisetIndex, int exerciseIndex) {
                _removeExercise(sportsDayIndex, multisetIndex, exerciseIndex, context);
              },

            )
          ],
        );
      },
    );
  }

  void _addExerciseToMultiset(int sportsDayIndex, int multisetIndex, BuildContext context) {

    context.read<SportsPlanProvider>().addExerciseToMultiset(sportsDayIndex, multisetIndex);
  }

  void _changeMuscleGroup(int sportsDayIndex, int multisetIndex, Exercise exercise, int exerciseIndex,
      String? newValue, BuildContext context) {

    context.read<SportsPlanProvider>().changeMuscleGroup(sportsDayIndex, multisetIndex, exercise, exerciseIndex, newValue);
  }

  void _changeExercise(int sportsDayIndex, int multisetIndex, Exercise exercise, int exerciseIndex,
      String? newValue, BuildContext context) {

    context.read<SportsPlanProvider>().changeExercise(sportsDayIndex, multisetIndex, exercise, exerciseIndex, newValue);
  }

  void _changeSetCount(int sportsDayIndex, int multisetIndex, Exercise exercise, int exerciseIndex,
      String? newValue, BuildContext context) {
    context.read<SportsPlanProvider>().changeSetCount(sportsDayIndex, multisetIndex, exercise, exerciseIndex, newValue);
  }

  void _changeRepCount(int sportsDayIndex, int multisetIndex, Exercise exercise, int exerciseIndex,
      String? newValue, BuildContext context) {
    context.read<SportsPlanProvider>().changeRepCount(sportsDayIndex, multisetIndex, exercise, exerciseIndex, newValue);
  }

  void _changeWeight(int sportsDayIndex, int multisetIndex, Exercise exercise, int exerciseIndex,
      String? newValue, BuildContext context) {

    context.read<SportsPlanProvider>().changeWeight(sportsDayIndex, multisetIndex, exercise, exerciseIndex, newValue);
  }

  void _removeExercise(int sportsDayIndex, int multisetIndex, int exerciseIndex, BuildContext context) {

    context.read<SportsPlanProvider>().removeExercise(sportsDayIndex, multisetIndex, exerciseIndex);
  }
}