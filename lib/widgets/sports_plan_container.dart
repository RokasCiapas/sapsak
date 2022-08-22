import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sapsak/providers/sports_plan_list_provider.dart';
import 'package:uuid/uuid.dart';

import '../models/exercise.dart';
import '../models/sports_day.dart';
import '../models/sports_plan.dart';
import 'exercise_list.dart';

class SportsPlanContainer extends StatelessWidget {
  const SportsPlanContainer({
    Key? key,
    required this.heightSpacer,
    required this.widthSpacer,
  }) : super(key: key);

  final SizedBox heightSpacer;
  final SizedBox widthSpacer;

  @override
  Widget build(BuildContext context) {
    SportsPlan sportsPlan = context.watch<SportsPlanProvider>().selectedSportsPlan;

    return ListView.builder(
      shrinkWrap: true,
      itemCount: sportsPlan.sportsDays.length,
      itemBuilder: (BuildContext context,
          int index) {
        SportsDay sportsDay = sportsPlan
            .sportsDays[index];
        return Column(
          children: [
            SizedBox(
              height: 60,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Day ${index + 1}',
                      style:
                      const TextStyle(
                          fontSize: 18))),
            ),
            Card(
              child: ExerciseList(
                heightSpacer: heightSpacer,
                widthSpacer: widthSpacer,
                sportsDay: sportsDay,
                makeSuperset: (exercise) {
                  String supersetWidth = const Uuid().v1();

                  sportsPlan.sportsDays[index].exercises.add(Exercise(
                      muscleGroup: 'Shoulders',
                      name: '',
                      repCount: 0,
                      setCount: 0,
                      id: supersetWidth,
                      supersetWidth: supersetWidth));

                  var newPlan = SportsPlan(
                      sportsDays: sportsPlan.sportsDays.map((day) => SportsDay(exercises: day.exercises.map((e) {
                        if (e.id == exercise.id) {
                          return Exercise(
                              muscleGroup: exercise.muscleGroup,
                              name: exercise.name,
                              repCount:exercise.repCount,
                              setCount: exercise.setCount,
                              id: exercise.id,
                              supersetWidth: exercise.supersetWidth
                          );
                        } else {
                          return e;
                        }
                      }).toList())
                      ).toList(),
                      ownerEmail: sportsPlan.ownerEmail,
                      notes: sportsPlan.notes,
                      goal: sportsPlan.goal,
                      isDraft: sportsPlan.isDraft,
                      id: sportsPlan.id
                  );
                  context.read<SportsPlanProvider>().setSelectedSportsPlan(newPlan);

                },
                changeMuscleGroup: (exercise, newValue) {

                  var newPlan = SportsPlan(
                      sportsDays: sportsPlan.sportsDays.map((day) => SportsDay(exercises: day.exercises.map((e) {
                        if (e.id == exercise.id) {
                          return Exercise(
                              muscleGroup: newValue ?? '',
                              name: exercise.name,
                              repCount: exercise.repCount,
                              setCount: exercise.setCount,
                              id: exercise.id,
                              supersetWidth: exercise.supersetWidth
                          );
                        } else {
                          return e;
                        }
                      }).toList())
                      ).toList(),
                      ownerEmail: sportsPlan.ownerEmail,
                      notes: sportsPlan.notes,
                      goal: sportsPlan.goal,
                      isDraft: sportsPlan.isDraft,
                      id: sportsPlan.id
                  );

                  context.read<SportsPlanProvider>().setSelectedSportsPlan(newPlan);

                },
                changeExercise: (exercise, newValue) {
                  exercise = Exercise(
                      muscleGroup: exercise.muscleGroup,
                      name: newValue,
                      repCount: exercise.repCount,
                      setCount: exercise.setCount,
                      id: exercise.id,
                      supersetWidth: exercise.supersetWidth
                  );
                },
                changeSetCount: (exercise, value) {
                  if (value.isNotEmpty) {
                    exercise = Exercise(muscleGroup: exercise.muscleGroup,
                        name: exercise.name,
                        repCount: exercise.repCount,
                        setCount: int.parse(value),
                        id: exercise.id,
                        supersetWidth: exercise.supersetWidth
                    );
                  }
                },
                changeRepCount: (exercise, value) {
                  if (value.isNotEmpty) {
                    exercise = Exercise(muscleGroup: exercise.muscleGroup,
                        name: exercise.name,
                        repCount: int.parse(value),
                        setCount: exercise.setCount,
                        id: exercise.id,
                        supersetWidth: exercise.supersetWidth
                    );
                  }
                },
              ),
            )
          ],
        );
      },
    );
  }
}
