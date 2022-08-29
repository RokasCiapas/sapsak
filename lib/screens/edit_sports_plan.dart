import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sapsak/models/client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sapsak/providers/client_provider.dart';
import 'package:sapsak/providers/sports_plan_list_provider.dart';
import 'package:sapsak/widgets/sports_plan_container.dart';

import '../models/sports_plan.dart';
import '../widgets/sports_plan_actions.dart';
import '../widgets/sports_plan_details.dart';

class EditSportsPlan extends StatelessWidget {
  final bool isEdit;

  const EditSportsPlan({
    Key? key,
    this.isEdit = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Client? client = context.read<ClientProvider>().selectedClient;

    final ScrollController listViewScrollController = ScrollController();
    final notesController = TextEditingController();
    final goalController = TextEditingController();
    final expirationDateController = TextEditingController();

    if (client != null) {
      SportsPlan sportsPlan = context.watch<SportsPlanProvider>().selectedSportsPlan;

      goalController.text = sportsPlan.goal;
      notesController.text = sportsPlan.notes;

      String setInitialExpirationDate(String newValue,
          Timestamp? oldValue) {
        if (newValue.isEmpty) {
          if (oldValue != null) {
            return DateFormat('yyyy-MM-dd')
                .format(sportsPlan.bestUntil!.toDate());
          }

          if (oldValue == null) {
            return DateFormat('yyyy-MM-dd').format(DateTime.now());
          }
        }

        return newValue;
      }

      expirationDateController.text = setInitialExpirationDate(
          expirationDateController.text, sportsPlan.bestUntil);

      return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text('${client.name} ${client.surname}'),
          ),
          body: Container(
              width: 992,
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.all(17),
              child: Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: ListView(
                        shrinkWrap: true,
                        controller: listViewScrollController,
                        children: [
                          SportsPlanDetails(
                              expirationDateController: expirationDateController,
                              goalController: goalController,
                              notesController: notesController
                          ),
                          const SportsPlanContainer()
                        ],
                      )),
                  SportsPlanActions(
                      isEdit: isEdit,
                      scrollController: listViewScrollController,
                      expirationDateController: expirationDateController,
                      notesController: notesController,
                      goalController: goalController
                  )
                ],
              )
          )
      );
    } else {
      return SizedBox();
    }

  }


}



