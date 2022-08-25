import 'package:flutter/material.dart';
import 'package:sapsak/models/sports_day.dart';

import '../models/exercise.dart';
import 'exercise_tile.dart';

class ExerciseList extends StatelessWidget {
  const ExerciseList({
    Key? key,
    required this.sportsDay,
    required this.addExerciseToMultiset,
    required this.changeMuscleGroup,
    required this.changeExercise,
    required this.changeSetCount,
    required this.changeRepCount
  }) : super(key: key, );

  final SportsDay sportsDay;
  final Function(int) addExerciseToMultiset;
  final Function(int, int, Exercise, String?) changeMuscleGroup;
  final Function(int, int, Exercise, String?) changeExercise;
  final Function(int, int, Exercise, String?) changeSetCount;
  final Function(int, int, Exercise, String?) changeRepCount;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: sportsDay.multisets.length,
          itemBuilder: (BuildContext context, int multisetIndex) {

            List<Exercise> multiset = sportsDay.multisets[multisetIndex]!.multiset;

            return ListView.builder(
                shrinkWrap: true,
                itemCount: multiset.length,
                itemBuilder: (BuildContext context, int exerciseIndex) {
                  Exercise exercise = multiset[exerciseIndex];

                  return ExerciseTile(
                    sequenceNumber: exerciseIndex,
                    muscleGroup: exercise.muscleGroup,
                    exercise: exercise.name,
                    setCount: exercise.setCount > 0 ? exercise.setCount.toString() : '',
                    repCount: exercise.repCount > 0 ? exercise.repCount.toString() : '',
                    makeSuperset: () {
                      addExerciseToMultiset(multisetIndex);
                    },
                    changeMuscleGroup: (newValue) {
                      changeMuscleGroup(multisetIndex, exerciseIndex, exercise, newValue);
                    },
                    changeExercise: (newValue) {
                      changeExercise(multisetIndex, exerciseIndex, exercise, newValue);
                    },
                    changeSetCount: (newValue) => {
                      changeSetCount(multisetIndex, exerciseIndex, exercise, newValue)
                    },
                    changeRepCount: (newValue) => {
                      changeRepCount(multisetIndex, exerciseIndex, exercise, newValue)
                    },
                  );
            }
            );
          }
      ),
    );
  }
}
