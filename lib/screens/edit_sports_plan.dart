import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sapsak/models/client.dart';
import 'package:sapsak/models/exercise.dart';
import 'package:sapsak/models/sports_day.dart';

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
  final sportsDays = List.filled(1, SportsDay(exercises: List.filled(1, Exercise(muscleGroup: 'Shoulders', name: '', repCount: 0, setCount: 0), growable: true)), growable: true);

  final ScrollController listViewScrollController = ScrollController();

  void scrollDown() {
    listViewScrollController.animateTo(
      9999999,
      duration: const Duration(seconds: 1),
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {

    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

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
                Expanded(flex: 1,
                    child: ListView(
                        shrinkWrap: true,
                        controller: listViewScrollController,
                        children: sportsDays.map((SportsDay sportsDay) =>
                            Column(
                              children: [
                                SizedBox(height: 60,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Day ${sportsDays.indexOf(sportsDay) + 1}',
                                          style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor)
                                      )
                                  ),),
                                ListView(
                                  shrinkWrap: true,
                                  children: sportsDay.exercises.map((Exercise exercise) =>
                                      Column(
                                        children: [
                                          CircleAvatar(child: Text((sportsDay.exercises.indexOf(exercise) + 1).toString())),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(flex: 0, child: DropdownButton<String>(
                                                value: exercise.muscleGroup,
                                                hint: const Text('Muscle group'),
                                                items: <String>['Shoulders', 'Biceps', 'Triceps', 'Chest', 'Abs', 'Back', 'Legs'].map((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    exercise = Exercise(
                                                        muscleGroup: newValue ?? '',
                                                        name: exercise.name,
                                                        repCount: exercise.repCount,
                                                        setCount: exercise.setCount);

                                                  });
                                                },
                                              ),),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(flex: 6, child: TextField(
                                                onChanged: (text) {
                                                  exercise = Exercise(
                                                      muscleGroup: exercise.muscleGroup,
                                                      name: text,
                                                      repCount: exercise.repCount,
                                                      setCount: exercise.setCount);
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
                                                    exercise = Exercise(
                                                        muscleGroup: exercise.muscleGroup,
                                                        name: exercise.name,
                                                        repCount: exercise.repCount,
                                                        setCount: int.parse(text));
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
                                                    exercise = Exercise(
                                                        muscleGroup: exercise.muscleGroup,
                                                        name: exercise.name,
                                                        repCount: int.parse(text),
                                                        setCount: exercise.setCount);
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
                                  ).toList(),
                                  // children: [
                                  //
                                  //   for( int i = 0 ; i < sportsDay.exercises.length ; i++)
                                  //
                                  // ],
                                )
                              ],
                            )
                        ).toList()
                    )),
                Row(children: [
                  Expanded(child: Padding(padding: const EdgeInsets.only(top: 20.0), child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        minimumSize: Size(w / 1.1, h / 15)),
                    onPressed: () => {
                      setState(() => {
                        sportsDays[sportsDays.length - 1].exercises.add(Exercise(muscleGroup: 'Shoulders', name: '', repCount: 0, setCount: 0)),
                        scrollDown()
                      }),

                    },
                    child: const Text("Add exercise"),
                  ),),),
                  const SizedBox(width: 15,),
                  Expanded(child: Padding(padding: const EdgeInsets.only(top: 20.0), child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        minimumSize: Size(w / 1.1, h / 15)),
                    onPressed: () => {
                      setState(() => {
                        sportsDays.add(SportsDay(exercises: List.filled(1, Exercise(muscleGroup: 'Shoulders', name: '', repCount: 0, setCount: 0), growable: true))),
                        scrollDown()
                      }),

                    },
                    child: const Text("Add day"),
                  ),),),
                  const SizedBox(width: 15,),
                  Expanded(child: Padding(padding: const EdgeInsets.only(top: 20.0), child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        minimumSize: Size(w / 1.1, h / 15)),
                    onPressed: () => {
                    },
                    child: const Text("Save"),
                  ),))
                ],)
              ],
            )
        )
    );
  }
}