import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sapsak/shared/height_spacer.dart';
import 'package:sapsak/shared/width_spacer.dart';

import '../shared/input.dart';

class SportsPlanDetails extends StatelessWidget {
  const SportsPlanDetails({
    Key? key,
    required this.expirationDateController,
    required this.goalController,
    required this.notesController,
  }) : super(key: key);

  final TextEditingController expirationDateController;
  final TextEditingController goalController;
  final TextEditingController notesController;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 15,
      runSpacing: 15,
      alignment: WrapAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: TextField(
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
                  firstDate: DateTime(1950), lastDate: DateTime(2101)
              );

              if (pickedDate != null) {
                String formattedDate =
                DateFormat('yyyy-MM-dd').format(pickedDate);expirationDateController.text = formattedDate;
              }
            },
          ),
        ),
        Input(
          controller: goalController,
          hintText: 'Goal',
          width: 250,
        ),
        Input(
          controller: notesController,
          maxLines: 2,
          hintText: 'Notes',
          flexibleWidth: true,
        ),
      ],
    );
  }
}
