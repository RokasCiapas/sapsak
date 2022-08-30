import 'package:flutter/material.dart';
import 'package:sapsak/models/sports_day.dart';

import '../models/exercise.dart';
import 'multiset_tile.dart';

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

    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: sportsDay.multisets.length,
        itemBuilder: (BuildContext context, int multisetIndex) {

          List<Exercise> multiset = sportsDay.multisets[multisetIndex]!.multiset;

          return MultisetTile(multiset: multiset, multisetIndex: multisetIndex, addExerciseToMultiset: addExerciseToMultiset, changeMuscleGroup: changeMuscleGroup, changeExercise: changeExercise, changeSetCount: changeSetCount, changeRepCount: changeRepCount);
        }
    );
  }
}

