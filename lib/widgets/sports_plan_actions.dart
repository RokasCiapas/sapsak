import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapsak/providers/client_provider.dart';
import 'package:sapsak/providers/sports_plan_list_provider.dart';
import 'package:uuid/uuid.dart';

import '../models/client.dart';
import '../models/exercise.dart';
import '../models/sports_day.dart';
import '../models/sports_plan.dart';
import '../services/sports_plan_service.dart';

class SportsPlanActions extends StatelessWidget {
  const SportsPlanActions({
    Key? key,
    required this.isEdit,
    required this.w,
    required this.h,
    required this.widthSpacer,
    required this.scrollController,
    required this.expirationDateController,
    required this.notesController,
    required this.goalController,
  }) : super(key: key);

  final bool isEdit;
  final double w;
  final double h;
  final SizedBox widthSpacer;
  final ScrollController scrollController;
  final TextEditingController expirationDateController;
  final TextEditingController notesController;
  final TextEditingController goalController;

  void scrollDown() {
    scrollController.animateTo(
      9999999,
      duration: const Duration(seconds: 1),
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {

    SportsPlan sportsPlan = context.read<SportsPlanProvider>().selectedSportsPlan;
    Client client = context.read<ClientProvider>().selectedClient!;

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(w / 1.1, h / 15)),
              onPressed: ()
              {

                sportsPlan.sportsDays[sportsPlan.sportsDays.length - 1].exercises.add(Exercise(
                    muscleGroup: 'Shoulders',
                    name: '',
                    repCount: 0,
                    setCount: 0,
                    id: const Uuid().v1(),
                    supersetWidth: ''

                ));

                context.read<SportsPlanProvider>().setSelectedSportsPlan(sportsPlan);

                scrollDown();
              },
              child: const Text("Add exercise"),
            ),
          ),
        ),
        widthSpacer,
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(w / 1.1, h / 15)),
              onPressed: () {
                sportsPlan.sportsDays.add(SportsDay(
                    exercises: List.filled(
                        1,
                        Exercise(
                            muscleGroup: 'Shoulders',
                            name: '',
                            repCount: 0,
                            setCount: 0,
                            id: const Uuid().v1(),
                            supersetWidth: ''

                        ),
                        growable: true)));


                context.read<SportsPlanProvider>().setSelectedSportsPlan(sportsPlan);

                scrollDown();
              },
              child: const Text("Add day"),
            ),
          ),
        ),
        widthSpacer,
        Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(w / 1.1, h / 15)),
                onPressed: () {
                  if (isEdit) {
                    editSportsPlan(sportsPlan, client, false).then((value) => Navigator.pop(context));
                  } else {
                    addSportsPlan(sportsPlan, client).then((value) => Navigator.pop(context));
                  }
                },
                child: const Text("Save"),
              ),
            )),
        widthSpacer,
        Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(w / 1.1, h / 15)),
                onPressed: () {
                  if (isEdit) {
                    editSportsPlan(sportsPlan, client, true).then((value) => Navigator.pop(context));
                  } else {
                    addSportsPlan(sportsPlan, client, isDraft: true).then((value) => Navigator.pop(context));
                  }
                },
                child: const Text("Save as Draft"),
              ),
            ))
      ],
    );
  }

  Future<DocumentReference<SportsPlan>> addSportsPlan(SportsPlan sportsPlan, Client client, {bool isDraft = false}) {
      return SportsPlanService().addSportsPlan(SportsPlan(
          sportsDays: sportsPlan.sportsDays,
          ownerEmail: client.email,
          createdAt:
          Timestamp.fromDate(DateTime.parse(DateTime.now()
              .toString())),
          bestUntil:
          Timestamp.fromDate(
              DateTime.parse(expirationDateController.text)),
          notes: notesController.text,
          goal: goalController.text,
          isDraft: isDraft,
          id: sportsPlan.id
      ));
  }

  Future<void> editSportsPlan(SportsPlan sportsPlan, Client client, bool isDraft) {
      return SportsPlanService().editSportsPlan(
          SportsPlan(
              sportsDays: sportsPlan.sportsDays,
              ownerEmail: client.email,
              createdAt:
              Timestamp.fromDate(DateTime.parse(DateTime.now()
                  .toString())),
              bestUntil: Timestamp.fromDate(
                  DateTime.parse(expirationDateController.text)),
              notes: notesController.text,
              goal: goalController.text,
              isDraft: isDraft,
              id: sportsPlan.id
          ),
          sportsPlan.id
      );
  }
}
