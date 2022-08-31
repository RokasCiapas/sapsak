import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapsak/providers/sports_plan_list_provider.dart';

import '../models/exercise.dart';
import '../models/sports_plan.dart';
import '../shared/button.dart';
import 'exercise_list.dart';

class SportsPlanContainer extends StatelessWidget {
  const SportsPlanContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SportsPlan sportsPlan = context.watch<SportsPlanProvider>().selectedSportsPlan;

    return ExpansionPanelList.radio(
      key: Key(sportsPlan.sportsDays.length.toString()),
      expansionCallback: (index, isExpanded) {

      },
      children: sportsPlan.sportsDays.map((sportsDay) {
        int sportsDayIndex = sportsPlan.sportsDays.indexOf(sportsDay);
        return ExpansionPanelRadio(
            canTapOnHeader: true,
            headerBuilder: (BuildContext context, bool isOpen) {
              return Padding(
                padding: EdgeInsets.all(15),
                child: Text('Day ${sportsDayIndex + 1}',
                    style: const TextStyle(fontSize: 18)),);
            },
            body: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
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
                    removeMultiset: (int multisetIndex) {
                      _removeMultiset(sportsDayIndex, multisetIndex, context);
                    },

                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Button(
                        onClick: ()
                        {
                          _addMultiset(sportsDayIndex, context);
                          // scrollDown();
                        },
                        text: 'Add multiset',
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Button(
                            onClick: ()
                            {
                              _removeDay(sportsDayIndex, context);
                            },
                            text: 'Remove day',
                          ),
                      )

                    ],
                  )
                ],
              ),
            ),
          value: sportsDayIndex
        );
      }).toList(),
    );
  }

  void _addExerciseToMultiset(int sportsDayIndex, int multisetIndex, BuildContext context) {

    context.read<SportsPlanProvider>().addExerciseToMultiset(sportsDayIndex, multisetIndex);
  }

  void _changeMuscleGroup(int sportsDayIndex, int multisetIndex, Exercise exercise, int exerciseIndex, String? newValue, BuildContext context) {

    context.read<SportsPlanProvider>().changeMuscleGroup(sportsDayIndex, multisetIndex, exercise, exerciseIndex, newValue);
  }

  void _changeExercise(int sportsDayIndex, int multisetIndex, Exercise exercise, int exerciseIndex, String? newValue, BuildContext context) {

    context.read<SportsPlanProvider>().changeExercise(sportsDayIndex, multisetIndex, exercise, exerciseIndex, newValue);
  }

  void _changeSetCount(int sportsDayIndex, int multisetIndex, Exercise exercise, int exerciseIndex, String? newValue, BuildContext context) {
    context.read<SportsPlanProvider>().changeSetCount(sportsDayIndex, multisetIndex, exercise, exerciseIndex, newValue);
  }

  void _changeRepCount(int sportsDayIndex, int multisetIndex, Exercise exercise, int exerciseIndex, String? newValue, BuildContext context) {
    context.read<SportsPlanProvider>().changeRepCount(sportsDayIndex, multisetIndex, exercise, exerciseIndex, newValue);
  }

  void _changeWeight(int sportsDayIndex, int multisetIndex, Exercise exercise, int exerciseIndex, String? newValue, BuildContext context) {

    context.read<SportsPlanProvider>().changeWeight(sportsDayIndex, multisetIndex, exercise, exerciseIndex, newValue);
  }

  void _removeExercise(int sportsDayIndex, int multisetIndex, int exerciseIndex, BuildContext context) {

    context.read<SportsPlanProvider>().removeExercise(sportsDayIndex, multisetIndex, exerciseIndex);
  }

  void _removeMultiset(int sportsDayIndex, int multisetIndex, BuildContext context) {

    context.read<SportsPlanProvider>().removeMultiset(sportsDayIndex, multisetIndex);
  }

  void _removeDay(int sportsDayIndex, BuildContext context) {

    context.read<SportsPlanProvider>().removeDay(sportsDayIndex);
  }

  void _addMultiset(int sportsDayIndex, BuildContext context) {


    context.read<SportsPlanProvider>().addMultiset(sportsDayIndex);

  }
}