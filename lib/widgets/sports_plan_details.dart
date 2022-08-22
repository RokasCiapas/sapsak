import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../shared/input.dart';

class SportsPlanDetails extends StatelessWidget {
  const SportsPlanDetails({
    Key? key,
    required this.expirationDateController,
    required this.heightSpacer,
    required this.goalController,
    required this.widthSpacer,
    required this.notesController,
  }) : super(key: key);

  final TextEditingController expirationDateController;
  final SizedBox heightSpacer;
  final TextEditingController goalController;
  final SizedBox widthSpacer;
  final TextEditingController notesController;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment
          .start,
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
                  DateTime? pickedDate =
                  await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(
                          1950),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    String formattedDate =
                    DateFormat('yyyy-MM-dd')
                        .format(pickedDate);
                    expirationDateController
                        .text =
                        formattedDate;
                  }
                },
              ),
              heightSpacer,
              Input(
                controller: goalController,
                hintText: 'Goal',
              )
            ],
          ),
        ),
        widthSpacer,
        Expanded(
            flex: 4,
            child: Input(
              controller: notesController,
              maxLines: 3,
              hintText: 'Notes',
            )),
      ],
    );
  }
}
