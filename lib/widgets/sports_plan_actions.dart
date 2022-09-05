import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapsak/models/multiset.dart';
import 'package:sapsak/providers/client_provider.dart';
import 'package:sapsak/providers/sports_plan_list_provider.dart';
import 'package:sapsak/shared/width_spacer.dart';

import '../models/client.dart';
import '../models/exercise.dart';
import '../models/sports_day.dart';
import '../models/sports_plan.dart';
import '../services/sports_plan_service.dart';
import '../shared/button.dart';

class SportsPlanActions extends StatelessWidget {
  const SportsPlanActions({
    Key? key,
    required this.isEdit,
    required this.expirationDateController,
    required this.notesController,
    required this.goalController,
    required this.onAddSportsDay,
  }) : super(key: key);

  final bool isEdit;
  final TextEditingController expirationDateController;
  final TextEditingController notesController;
  final TextEditingController goalController;
  final VoidCallback onAddSportsDay;

  @override
  Widget build(BuildContext context) {

    SportsPlan sportsPlan = context.read<SportsPlanProvider>().selectedSportsPlan;
    Client client = context.read<ClientProvider>().selectedClient!;

    return Row(
      children: [
        const WidthSpacer(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Button(
              onClick: () {
                _addSportsDay(sportsPlan, context);
                onAddSportsDay();
              },
              text: 'Add day',
            ),
          ),
        ),
        const WidthSpacer(),
        Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Button(
                onClick: () {
                  if (isEdit) {
                    editSportsPlan(sportsPlan, client, false).then((value) => Navigator.pop(context));
                  } else {
                    addSportsPlan(sportsPlan, client).then((value) => Navigator.pop(context));
                  }
                },
                text: 'Save',
              ),
            )),
        const WidthSpacer(),
        Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Button(
                onClick: () {
                  if (isEdit) {
                    editSportsPlan(sportsPlan, client, true).then((value) => Navigator.pop(context));
                  } else {
                    addSportsPlan(sportsPlan, client, isDraft: true).then((value) => Navigator.pop(context));
                  }
                },
                text: 'Save as Draft',
              ),
            ))
      ],
    );
  }

  void _addSportsDay(SportsPlan sportsPlan, BuildContext context) {
    SportsPlan newSportsPlan = sportsPlan;

    newSportsPlan.sportsDays.add(SportsDay(
        multisets: {
          0: Multiset(multiset: [const Exercise(
              muscleGroup: 'Shoulders',
              name: '',
              repCount: 0,
              setCount: 0,
              weight: ''
          )])
        }));

    context.read<SportsPlanProvider>().setSelectedSportsPlan(sportsPlan);
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
