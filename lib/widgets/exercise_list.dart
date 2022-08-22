import 'package:uuid/uuid.dart';

import 'package:flutter/material.dart';
import 'package:sapsak/models/sports_day.dart';

import '../models/exercise.dart';
import 'exercise_tile.dart';

class ExerciseList extends StatelessWidget {
  const ExerciseList({
    Key? key,
    required this.sportsDay,
    required this.heightSpacer,
    required this.widthSpacer,
    required this.makeSuperset,
    required this.changeMuscleGroup,
    required this.changeExercise,
    required this.changeSetCount,
    required this.changeRepCount
  }) : super(key: key, );

  final SportsDay sportsDay;
  final SizedBox heightSpacer;
  final SizedBox widthSpacer;
  final Function(Exercise) makeSuperset;
  final Function(Exercise, String?) changeMuscleGroup;
  final Function(Exercise, String) changeExercise;
  final Function(Exercise, String) changeSetCount;
  final Function(Exercise, String) changeRepCount;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all(20),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: sportsDay.exercises.length,
        itemBuilder: (BuildContext context, int i) {
          var exercise = sportsDay.exercises[i];

          if (exercise.supersetWidth.isEmpty) {
            return ExerciseTile(
              heightSpacer: heightSpacer,
              widthSpacer: widthSpacer,
              muscleGroup: exercise.muscleGroup,
              exercise: exercise.name,
              setCount: exercise.setCount > 0 ? exercise.setCount.toString() : '',
              repCount: exercise.repCount > 0 ? exercise.repCount.toString() : '',
              makeSuperset: () {
                makeSuperset(exercise);
              },
              changeMuscleGroup: (newValue) {
                changeMuscleGroup(exercise, newValue);
              },
              changeExercise: (value) {
                changeExercise(exercise, value);
              },
              changeSetCount: (value) => {
                changeSetCount(exercise, value)
              },
              changeRepCount: (value) => {
                changeRepCount(exercise, value)
              },
            );
          } else {
            return ExerciseTile(
              heightSpacer: heightSpacer,
              widthSpacer: widthSpacer,
              muscleGroup: exercise.muscleGroup,
              exercise: exercise.name,
              setCount: exercise.setCount > 0 ? exercise.setCount.toString() : '',
              repCount: exercise.repCount > 0 ? exercise.repCount.toString() : '',
              changeMuscleGroup: (newValue) {
                changeMuscleGroup(exercise, newValue);
              },
              changeExercise: (value) {
                changeExercise(exercise, value);
              },
              changeSetCount: (value) => {
                changeSetCount(exercise, value)
              },
              changeRepCount: (value) => {
                changeRepCount(exercise, value)
              },
            );
          }
        }
    ),
    );
  }
}
