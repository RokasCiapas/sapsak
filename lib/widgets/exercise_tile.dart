import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sapsak/shared/height_spacer.dart';
import 'package:sapsak/shared/width_spacer.dart';

import '../shared/button.dart';

class ExerciseTile extends StatelessWidget {
  const ExerciseTile({
    Key? key,
    required this.sequenceNumber,
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

  final int sequenceNumber;
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
            Text('Exercise no: $sequenceNumber', style: const TextStyle(
                fontSize: 16),),
            const Spacer(),
            makeSuperset == null ? const SizedBox() : Padding(
              padding: const EdgeInsets.only(
                  top: 20.0),
              child: Button(
                onClick: () {
                  makeSuperset!();
                },
                text: 'Add exercise',
              ),
            ),
          ],
        ),
        const HeightSpacer(),
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
            const WidthSpacer(),
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
        const WidthSpacer(),
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
            const WidthSpacer(),
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
        const HeightSpacer(),
      ],
    );
  }
}
