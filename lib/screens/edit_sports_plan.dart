import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sapsak/models/client.dart';
import 'package:sapsak/models/exercise.dart';
import 'package:sapsak/models/sports_day.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:sapsak/services/sports_plan_service.dart';

import '../models/sports_plan.dart';

class EditSportsPlan extends StatefulWidget {

  const EditSportsPlan({
    Key? key,
    required this.sportsPlan,
    required this.client,
    this.isEdit = false,
    this.sportsPlanId = '',
  }) : super(key: key);

  final SportsPlan sportsPlan;
  final Client client;
  final bool isEdit;
  final String sportsPlanId;

  @override
  State<EditSportsPlan> createState() => _EditSportsPlanState();
}

class _EditSportsPlanState extends State<EditSportsPlan> {

  final ScrollController listViewScrollController = ScrollController();
  final notesController = TextEditingController();
  final goalController = TextEditingController();
  final expirationDateController = TextEditingController();

  static const widthSpacer = SizedBox(width: 15,);
  static const heightSpacer = SizedBox(height: 15,);

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
    expirationDateController.text = setInitialExpirationDate(expirationDateController.text, widget.sportsPlan.bestUntil);
    goalController.text = widget.sportsPlan.goal;
    notesController.text = widget.sportsPlan.notes;


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
                    flex: 1,
                    child: ListView(
                      shrinkWrap: true,
                      controller: listViewScrollController,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                children: [
                                  TextField(
                                    controller: expirationDateController,
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Expiration date',
                                    ),
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: context, initialDate: DateTime.now(),
                                          firstDate: DateTime(1950), //DateTime.now() - not to allow to choose before today.
                                          lastDate: DateTime(2101)
                                      );

                                      if(pickedDate != null ){
                                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                        setState(() {
                                          expirationDateController.text = formattedDate; //set output date to TextField value.
                                        });
                                      }
                                    },
                                  ),
                                  heightSpacer,
                                  TextField(
                                    controller: goalController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Goal',
                                    ),
                                  )
                                ],
                              ),),
                            widthSpacer,
                            Expanded(
                                flex: 4,
                                child: TextField(
                                  controller: notesController,
                                  maxLines: 3,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Notes',
                                  ),
                                )
                            ),
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.sportsPlan.sportsDays.length,
                          itemBuilder: (BuildContext context, int index) {
                            SportsDay? sportsDay = widget.sportsPlan.sportsDays[index];
                            return Column(
                              children: [
                                SizedBox(height: 60,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Day ${index + 1}',
                                          style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor)
                                      )
                                  ),),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: sportsDay.exercises.length,
                                  itemBuilder: (BuildContext context, int i) {
                                    return Column(
                                      children: [
                                        CircleAvatar(child: Text((i + 1).toString())),
                                        heightSpacer,
                                        Row(
                                          children: [
                                            Expanded(flex: 0,
                                              child: DropdownButton<String>(
                                                value: sportsDay.exercises[i].muscleGroup,
                                                hint: const Text('Muscle group'),
                                                items: <String>['Shoulders', 'Biceps', 'Triceps', 'Chest', 'Abs', 'Back', 'Legs'].map((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    sportsDay.exercises[i] = Exercise(
                                                        muscleGroup: newValue ?? '',
                                                        name: sportsDay.exercises[i].name,
                                                        repCount: sportsDay.exercises[i].repCount,
                                                        setCount: sportsDay.exercises[i].setCount);
                                                  });
                                                },
                                              ),),
                                            widthSpacer,
                                            Expanded(flex: 6, child: TextFormField(
                                              initialValue: sportsDay.exercises[i].name,
                                              onChanged: (text) {
                                                sportsDay.exercises[i] = Exercise(
                                                    muscleGroup: sportsDay.exercises[i].muscleGroup,
                                                    name: text,
                                                    repCount: sportsDay.exercises[i].repCount,
                                                    setCount: sportsDay.exercises[i].setCount);
                                              },
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: 'Exercise',
                                              ),
                                            ),)
                                          ],
                                        ),
                                        heightSpacer,
                                        Row(
                                          children: [
                                            Expanded(flex: 1, child: TextFormField(
                                              initialValue: sportsDay.exercises[i].setCount > 0 ? sportsDay.exercises[i].setCount.toString() : '',
                                              onChanged: (text) {
                                                if (text.isNotEmpty) {
                                                  sportsDay.exercises[i] = Exercise(
                                                      muscleGroup: sportsDay.exercises[i].muscleGroup,
                                                      name: sportsDay.exercises[i].name,
                                                      repCount: sportsDay.exercises[i].repCount,
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
                                            widthSpacer,
                                            Expanded(flex: 1, child: TextFormField(
                                              initialValue: sportsDay.exercises[i].repCount > 0 ? sportsDay.exercises[i].repCount.toString() : '',
                                              onChanged: (text) {
                                                if (text.isNotEmpty) {
                                                  sportsDay.exercises[i] = Exercise(
                                                      muscleGroup: sportsDay.exercises[i].muscleGroup,
                                                      name: sportsDay.exercises[i].name,
                                                      repCount: int.parse(text),
                                                      setCount: sportsDay.exercises[i].setCount);
                                                }
                                              },
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: 'Rep count',
                                              ),
                                            ))
                                          ],
                                        ),
                                        heightSpacer,
                                      ],
                                    );
                                  },

                                )
                              ],
                            );

                          },
                        )
                      ],
                    )
                ),
                Row(children: [
                  Expanded(child: Padding(padding: const EdgeInsets.only(top: 20.0), child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        minimumSize: Size(w / 1.1, h / 15)),
                    onPressed: () => {
                      setState(() => {
                        widget.sportsPlan.sportsDays[widget.sportsPlan.sportsDays.length - 1].exercises.add(const Exercise(muscleGroup: 'Shoulders', name: '', repCount: 0, setCount: 0)),
                        scrollDown()
                      }),
                    },
                    child: const Text("Add exercise"),
                  ),),),
                  widthSpacer,
                  Expanded(child: Padding(padding: const EdgeInsets.only(top: 20.0), child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        minimumSize: Size(w / 1.1, h / 15)),
                    onPressed: () => {
                      setState(() => {
                        widget.sportsPlan.sportsDays.add(SportsDay(exercises: List.filled(1, const Exercise(muscleGroup: 'Shoulders', name: '', repCount: 0, setCount: 0), growable: true))),
                        scrollDown()
                      }),

                    },
                    child: const Text("Add day"),
                  ),),),
                  widthSpacer,
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor,
                              minimumSize: Size(w / 1.1, h / 15)),
                          onPressed: () => {
                            widget.isEdit ? editSportsPlan(widget.sportsPlanId, false) : addSportsPlan()
                          },
                          child: widget.isEdit ? const Text("Edit") : const Text("Save"),
                        ),
                      )
                  ),
                  widthSpacer,
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor,
                              minimumSize: Size(w / 1.1, h / 15)),
                          onPressed: () => {
                            widget.isEdit ? editSportsPlan(widget.sportsPlanId, true) : addSportsPlan(isDraft: true)
                          },
                          child: widget.isEdit ? const Text("Edit as Draft") : const Text("Save as Draft"),
                        ),
                      )
                  )
                ],)
              ],
            )
        )
    );
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  String setInitialExpirationDate(String newValue, Timestamp? oldValue) {
    if (newValue.isEmpty) {
      if (oldValue != null) {
        return DateFormat('yyyy-MM-dd').format(widget.sportsPlan.bestUntil!.toDate());
      }

      if (oldValue == null) {
        return DateFormat('yyyy-MM-dd').format(DateTime.now());
      }
    }

    return newValue;
  }

  void addSportsPlan({bool isDraft = false}) {
    SportsPlanService().addSportsPlan(
        SportsPlan(
            sportsDays: widget.sportsPlan.sportsDays,
            ownerEmail: widget.client.email,
            createdAt: Timestamp.fromDate(DateTime.parse(DateTime.now().toString())),
            bestUntil: Timestamp.fromDate(DateTime.parse(expirationDateController.text)),
            notes: notesController.text,
            goal: goalController.text,
            isDraft: isDraft
        )
    );
  }

  void editSportsPlan(String sportsPlanId, bool isDraft) {
    SportsPlanService().editSportsPlan(SportsPlan(
        sportsDays: widget.sportsPlan.sportsDays,
        ownerEmail: widget.client.email,
        createdAt: Timestamp.fromDate(DateTime.parse(DateTime.now().toString())),
        bestUntil: Timestamp.fromDate(DateTime.parse(expirationDateController.text)),
        notes: notesController.text,
        goal: goalController.text,
        isDraft: isDraft
    ), sportsPlanId);
  }
}