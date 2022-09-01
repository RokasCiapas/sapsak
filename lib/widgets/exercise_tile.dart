import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sapsak/shared/width_spacer.dart';

class ExerciseTile extends StatelessWidget {
  const ExerciseTile({
    Key? key,
    required this.sequenceNumber,
    required this.muscleGroup,
    required this.exercise,
    required this.setCount,
    required this.repCount,
    required this.weight,
    required this.changeMuscleGroup,
    required this.changeExercise,
    required this.changeSetCount,
    required this.changeRepCount,
    required this.changeWeight,
    required this.removeExercise,
  }) : super(key: key);

  final int sequenceNumber;
  final String muscleGroup;
  final String exercise;
  final String setCount;
  final String repCount;
  final String weight;
  final Function(String?) changeMuscleGroup;
  final Function(String) changeExercise;
  final Function(String) changeSetCount;
  final Function(String) changeRepCount;
  final Function(String) changeWeight;
  final Function(int) removeExercise;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DropdownButton<String>(
          isDense: true,
          value: muscleGroup,
          hint: const Text('Muscle group'),
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
        const WidthSpacer(),
        Expanded(
          flex: 1,
          child: TextFormField(
            style: const TextStyle(fontSize: 15),
            initialValue: exercise,
            onChanged: (text) {
              changeExercise(text);
            },
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(12),
              border: OutlineInputBorder(),
              hintText: 'Exercise',
              isDense: true,
            ),
          ),
        ),
        const WidthSpacer(),
        SizedBox(
          width: 100,
          child: TextFormField(
            style: const TextStyle(fontSize: 15),
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
              contentPadding: EdgeInsets.all(12),
              isDense: true,
              hintText: 'Set count',
            ),
          ),
        ),
        const WidthSpacer(),
        SizedBox(
          width: 150,
          child: TextFormField(
            style: const TextStyle(fontSize: 15),
            initialValue: repCount,
            onChanged: (text) {
              changeRepCount(text);
            },
            decoration:
            const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12),
              isDense: true,
              hintText: 'Rep count',
            ),
          ),
        ),
        const WidthSpacer(),
        SizedBox(
          width: 132,
          child: TextFormField(
            style: const TextStyle(fontSize: 15),
            initialValue: weight,
            onChanged: (text) {
              changeWeight(text);
            },
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(12),
              isDense: true,
              border: OutlineInputBorder(),
              hintText: 'Weight',
            ),
          ),
        ),
        const WidthSpacer(),
        ElevatedButton(
          onPressed: () {
            removeExercise(sequenceNumber);
          },
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(10)
          ),
          child: const Icon(Icons.close, size: 13,),
        ),
      ],
    );
  }
}
