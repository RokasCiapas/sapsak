import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sapsak/models/client.dart';
import 'package:sapsak/models/exercise.dart';
import 'package:supercharged/supercharged.dart';

class EditSportsPlan extends StatefulWidget {
  const EditSportsPlan({
    Key? key,
    required this.client,
  }) : super(key: key);

  final Client client;

  @override
  State<EditSportsPlan> createState() => _EditSportsPlanState();

}

class _EditSportsPlanState extends State<EditSportsPlan> {
  final exercises = List.filled(1, Exercise(muscleGroup: 'Shoulders', name: '', repCount: 0, setCount: 0), growable: true);

  String dropdownValue = 'Shoulders';
  final ScrollController listViewScrollController = ScrollController();
  final double _height = 180.0;

  void animateToIndex(int index) {
    listViewScrollController.animateTo(
      index * _height,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    final exerciseController = TextEditingController();
    final setCountController = TextEditingController();
    final repCountController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xff35b9d6),
            foregroundColor: Colors.white,
            automaticallyImplyLeading: true,
            title: Text('${widget.client.name} ${widget.client.surname}')
        ),
        body: Container(
            width: w,
            margin: const EdgeInsets.all(17),
            child: Column(
              children: [
                Expanded(
                    child: ListView(
                      controller: listViewScrollController,
                      children: [

                        for( int i = 0 ; i < exercises.length ; i++)
                          Column(
                            children: [
                              CircleAvatar(child: Text((i + 1).toString())),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Expanded(flex: 0, child: DropdownButton<String>(
                                    value: exercises[i].muscleGroup,
                                    hint: const Text('Muscle group'),
                                    items: <String>['Shoulders', 'Biceps', 'Triceps', 'Chest', 'Abs', 'Back', 'Legs'].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        exercises[i] = Exercise(muscleGroup: newValue ?? '', name: exercises[i].name, repCount: exercises[i].repCount, setCount: exercises[i].setCount);

                                      });
                                    },
                                  ),),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(flex: 6, child: TextField(
                                    onChanged: (text) {
                                      exercises[i] = Exercise(muscleGroup: exercises[i].muscleGroup, name: text, repCount: exercises[i].repCount, setCount: exercises[i].setCount);
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Exercise',
                                    ),
                                  ),)
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Expanded(flex: 1, child: TextField(
                                    onChanged: (text) {
                                      if (text.isNotEmpty) {
                                        exercises[i] = Exercise(muscleGroup: exercises[i].muscleGroup, name: exercises[i].name, repCount: exercises[i].repCount, setCount: int.parse(text));
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Set count',
                                    ),
                                  )),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(flex: 1, child: TextField(
                                    onChanged: (text) {
                                      if (text.isNotEmpty) {
                                        exercises[i] = Exercise(muscleGroup: exercises[i].muscleGroup, name: exercises[i].name, repCount: int.parse(text), setCount: exercises[i].setCount);
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Rep count',
                                    ),
                                  ))
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          )

                      ],
                    )
                ),
                Padding(padding: const EdgeInsets.only(top: 20.0), child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      minimumSize: Size(w / 1.1, h / 15)),
                  onPressed: () => {
                    setState(() => {
                      exercises.add(Exercise(muscleGroup: 'Shoulders', name: '', repCount: 0, setCount: 0))
                    }),
                    animateToIndex(exercises.length)
                  },
                  child: const Text("Add exercise"),
                ),),
                Padding(padding: const EdgeInsets.only(top: 20.0), child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      minimumSize: Size(w / 1.1, h / 15)),
                  onPressed: () => {
                    setState(() => {
                      exercises.add(Exercise(muscleGroup: 'Shoulders', name: '', repCount: 0, setCount: 0))
                    }),
                    animateToIndex(exercises.length)
                  },
                  child: const Text("Save"),
                ),)
              ],
            )
        )
    );
  }
}