import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapsak/providers/sports_plan_list_provider.dart';
import 'package:sapsak/shared/dialog_utils.dart';

import '../models/exercise.dart';
import '../models/sports_plan.dart';
import '../shared/button.dart';
import 'exercise_list.dart';

class SportsPlanContainer extends StatelessWidget {
  const SportsPlanContainer({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SportsPlan sportsPlan = context.watch<SportsPlanProvider>().selectedSportsPlan;

    return ChangeNotifierProxyProvider<SportsPlanProvider, ExpansionState>(
      create: (_) => ExpansionState(),
      update: (_, sportsPlanProvider, expansionState) => expansionState!..addItem(sportsPlanProvider.selectedSportsPlan.sportsDays.length),
      builder: (context, child) {
        List<bool> expansionList = context.watch<ExpansionState>()._list;
        return ExpansionPanelList(
          key: Key(sportsPlan.sportsDays.length.toString()),
          expansionCallback: (int panelIndex, bool isExpanded) {
            context.read<ExpansionState>().changeState(panelIndex, isExpanded);
          },
          children: sportsPlan.sportsDays.map((sportsDay) {
            int sportsDayIndex = sportsPlan.sportsDays.indexOf(sportsDay);
            return ExpansionPanel(
                isExpanded: expansionList[sportsDayIndex],
                canTapOnHeader: true,
                headerBuilder: (BuildContext context, bool isOpen) {
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text('Day ${sportsDayIndex + 1}',
                        style: const TextStyle(fontSize: 18)),);
                },
                body: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      ExerciseList(
                        sportsDay: sportsDay,
                        addExerciseToMultiset: (int multisetIndex) {
                          context.read<SportsPlanProvider>()
                              .addExerciseToMultiset(
                              sportsDayIndex, multisetIndex);
                        },
                        changeMuscleGroup: (int multisetIndex,
                            int exerciseIndex, Exercise exercise,
                            String? newValue) {
                          context.read<SportsPlanProvider>()
                              .changeMuscleGroup(
                              sportsDayIndex, multisetIndex, exercise,
                              exerciseIndex, newValue);
                        },
                        changeExercise: (int multisetIndex, int exerciseIndex,
                            Exercise exercise, String? newValue) {
                          context.read<SportsPlanProvider>().changeExercise(
                              sportsDayIndex, multisetIndex, exercise,
                              exerciseIndex, newValue);
                        },
                        changeSetCount: (int multisetIndex, int exerciseIndex,
                            Exercise exercise, String? newValue) {
                          context.read<SportsPlanProvider>().changeSetCount(
                              sportsDayIndex, multisetIndex, exercise,
                              exerciseIndex, newValue);
                        },
                        changeRepCount: (int multisetIndex, int exerciseIndex,
                            Exercise exercise, String? newValue) {
                          context.read<SportsPlanProvider>().changeRepCount(
                              sportsDayIndex, multisetIndex, exercise,
                              exerciseIndex, newValue);
                        },
                        changeWeight: (int multisetIndex, int exerciseIndex,
                            Exercise exercise, String? newValue) {
                          context.read<SportsPlanProvider>().changeWeight(
                              sportsDayIndex, multisetIndex, exercise,
                              exerciseIndex, newValue);
                        },
                        removeExercise: (int multisetIndex, int exerciseIndex) {
                          context.read<SportsPlanProvider>().removeExercise(sportsDayIndex, multisetIndex, exerciseIndex);
                        },
                        removeMultiset: (int multisetIndex) {
                          context.read<SportsPlanProvider>().removeMultiset(sportsDayIndex, multisetIndex);
                        },

                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Button(
                            onClick: () {
                              context.read<SportsPlanProvider>().addMultiset(sportsDayIndex);
                              // scrollDown();
                            },
                            text: 'Add multiset',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Button(
                              onClick: () {
                                DialogUtils.displayDialogOKCallBack(context, 'Do you want to remove day?', '').then((value) => {
                                  if (value == true) {
                                    context.read<SportsPlanProvider>().removeDay(sportsDayIndex)
                                  }
                                });
                              },
                              text: 'Remove day',
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
            );
          }).toList(),
        );
      }
      ,);
  }
}

class ExpansionState with ChangeNotifier {
  final List<bool> _list = [true];

  changeState(int index, bool isExpanded) {
    _list[index] = !isExpanded;
    notifyListeners();
  }

  addItem(int itemCountToAdd) {

    if (itemCountToAdd > 1) {
      for (var i = 1; i <= itemCountToAdd; i++) {
        _list.add(false);
      }
    } else {
      _list.add(true);
    }
    notifyListeners();
  }

}