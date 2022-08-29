import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExerciseTile extends StatelessWidget {
  const ExerciseTile({
    Key? key,
    required this.sequenceNumber,
    required this.muscleGroup,
    required this.exercise,
    required this.setCount,
    required this.repCount,
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
  final Function(String?) changeMuscleGroup;
  final Function(String) changeExercise;
  final Function(String) changeSetCount;
  final Function(String) changeRepCount;

  @override
  Widget build(BuildContext context) {

    return Wrap(
      spacing: 15,
      runSpacing: 15,
      alignment: WrapAlignment.start,
      children: [
        DropdownButton<String>(
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
        SizedBox(
          width: 350,
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
        ),
        SizedBox(
          width: 100,
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
          ),
        ),
        SizedBox(
          width: 150,
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
          ),
        ),
        SizedBox(
          width: 132,
          child: TextFormField(
            initialValue: exercise,
            onChanged: (text) {},
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Weight',
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20)
          ),
          child: const Icon(Icons.close),
        ),
      ],
    );
  }
}
