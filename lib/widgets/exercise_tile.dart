import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExerciseTile extends StatelessWidget {
  const ExerciseTile({
    Key? key,
    required this.w,
    required this.h,
    required this.heightSpacer,
    required this.widthSpacer,
    required this.muscleGroup,
    required this.exercise,
    required this.setCount,
    required this.repCount,
    this.makeSuperset,
    required this.changeMuscleGroup,
    required this.changeExercise,
    required this.changeSetCount,
    required this.changeRepCount
  }) : super(key: key);

  final double w;
  final double h;
  final SizedBox heightSpacer;
  final SizedBox widthSpacer;
  final String muscleGroup;
  final String exercise;
  final String setCount;
  final String repCount;
  final VoidCallback? makeSuperset;
  final Function(String?) changeMuscleGroup;
  final Function(String) changeExercise;
  final Function(String) changeSetCount;
  final Function(String) changeRepCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Spacer(),
            makeSuperset == null ? const SizedBox() : Padding(
              padding: const EdgeInsets.only(
                  top: 20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(w / 12, h / 15)),
                onPressed: makeSuperset,
                child: const Text("Make Superset"),
              ),
            ),
          ],
        ),
        heightSpacer,
        Row(
          children: [
            Expanded(
              flex: 0,
              child: DropdownButton<String>(
                value: muscleGroup,
                hint:
                const Text('Muscle group'),
                items: <String>['Shoulders', 'Biceps', 'Triceps', 'Chest', 'Abs', 'Back', 'Legs'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  changeMuscleGroup(newValue);
                },
              ),
            ),
            widthSpacer,
            Expanded(
              flex: 6,
              child: TextFormField(
                initialValue: exercise,
                onChanged: (text) {
                  changeExercise(text);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Exercise',
                ),
              ),
            )
          ],
        ),
        heightSpacer,
        Row(
          children: [
            Expanded(
                flex: 1,
                child: TextFormField(
                  initialValue: setCount,
                  onChanged: (text) {
                    changeSetCount(text);
                  },
                  keyboardType:
                  TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration:
                  const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Set count',
                  ),
                )
            ),
            widthSpacer,
            Expanded(
                flex: 1,
                child: TextFormField(
                  initialValue: repCount,
                  onChanged: (text) {
                    changeRepCount(text);
                  },
                  decoration:
                  const InputDecoration(
                    border:
                    OutlineInputBorder(),
                    hintText: 'Rep count',
                  ),
                )
            )
          ],
        ),
        heightSpacer,
      ],
    );
  }
}
