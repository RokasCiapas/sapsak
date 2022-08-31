import 'package:flutter/material.dart';

import '../models/exercise.dart';
import '../shared/button.dart';
import 'exercise_tile.dart';

class MultisetTile extends StatelessWidget {
  const MultisetTile({
    Key? key,
    required this.multiset,
    required this.addExerciseToMultiset,
    required this.multisetIndex,
    required this.changeMuscleGroup,
    required this.changeExercise,
    required this.changeSetCount,
    required this.changeRepCount,
    required this.changeWeight,
    required this.removeExercise,
    required this.removeMultiset,
  }) : super(key: key);

  final List<Exercise> multiset;
  final int multisetIndex;
  final Function(int p1) addExerciseToMultiset;
  final Function(int p1, int p2, Exercise p3, String? p4) changeMuscleGroup;
  final Function(int p1, int p2, Exercise p3, String? p4) changeExercise;
  final Function(int p1, int p2, Exercise p3, String? p4) changeSetCount;
  final Function(int p1, int p2, Exercise p3, String? p4) changeRepCount;
  final Function(int p1, int p2, Exercise p3, String? p4) changeWeight;
  final Function(int p1, int p2) removeExercise;
  final Function(int p1) removeMultiset;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListView.builder(
              key: Key(multiset.length.toString()),
              shrinkWrap: true,
              itemCount: multiset.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int exerciseIndex) {
                Exercise exercise = multiset[exerciseIndex];

                return ExerciseTile(
                  sequenceNumber: exerciseIndex,
                  muscleGroup: exercise.muscleGroup,
                  exercise: exercise.name,
                  setCount: exercise.setCount > 0 ? exercise.setCount.toString() : '',
                  repCount: exercise.repCount > 0 ? exercise.repCount.toString() : '',
                  weight: exercise.weight,
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
                  changeWeight: (newValue) => {
                    changeWeight(multisetIndex, exerciseIndex, exercise, newValue)
                  },
                  removeExercise: (index) => {
                    removeExercise(multisetIndex, index)
                  },
                );
              }
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0),
                child: Button(
                  onClick: () {
                    addExerciseToMultiset(multisetIndex);
                  },
                  text: 'Add exercise',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0,
                    top: 20.0),
                child: Button(
                  onClick: () {
                    removeMultiset(multisetIndex);
                  },
                  text: 'Remove multiset',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }


}
