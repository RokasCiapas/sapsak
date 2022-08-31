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
    required this.changeRepCount,
    required this.changeWeight,
    required this.removeExercise,
    required this.removeMultiset,
  }) : super(key: key, );

  final SportsDay sportsDay;
  final Function(int) addExerciseToMultiset;
  final Function(int, int, Exercise, String?) changeMuscleGroup;
  final Function(int, int, Exercise, String?) changeExercise;
  final Function(int, int, Exercise, String?) changeSetCount;
  final Function(int, int, Exercise, String?) changeRepCount;
  final Function(int, int, Exercise, String?) changeWeight;
  final Function(int, int) removeExercise;
  final Function(int) removeMultiset;

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        key: Key(sportsDay.multisets.length.toString()),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: sportsDay.multisets.length,
        itemBuilder: (BuildContext context, int multisetIndex) {
          int key = sportsDay.multisets.keys.elementAt(multisetIndex);

          List<Exercise>? multiset = sportsDay.multisets[key]?.multiset;

          if (multiset != null) {
            return Column(
                children: [
                  SizedBox(
                    height: 20,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Multiset ${multisetIndex + 1}',
                            style:
                            const TextStyle(
                                fontSize: 15))),
                  ),
                  MultisetTile(
                    multiset: multiset,
                    multisetIndex: key,
                    addExerciseToMultiset: addExerciseToMultiset,
                    changeMuscleGroup: changeMuscleGroup,
                    changeExercise: changeExercise,
                    changeSetCount: changeSetCount,
                    changeRepCount: changeRepCount,
                    changeWeight: changeWeight,
                    removeExercise: removeExercise,
                    removeMultiset: removeMultiset,
                  ),
                  Divider()
                ]
            );
          } else {
            return const SizedBox.shrink();
          }
        }
    );
  }
}

