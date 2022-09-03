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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= 599) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: TextField(
                      style: const TextStyle(fontSize: 15),
                      controller: expirationDateController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(12),
                        hintText: 'Expiration date',
                        isDense: true,
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
                  const WidthSpacer(),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 35,
                      child: Input(
                        controller: goalController,
                        hintText: 'Goal',
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
              const HeightSpacer(),
              Input(
                controller: notesController,
                maxLines: 2,
                hintText: 'Notes',
                flexibleWidth: true,
                isDense: true,
              ),
            ],
          );
        } else {
          return Wrap(
            spacing: 15,
            runSpacing: 5,
            children: [
              SizedBox(
                width: 110,
                child: TextField(
                  style: const TextStyle(fontSize: 15),
                  controller: expirationDateController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(12),
                    hintText: 'Expiration date',
                    isDense: true,
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
                isDense: true,
              ),
              Input(
                controller: notesController,
                maxLines: 2,
                hintText: 'Notes',
                flexibleWidth: true,
                isDense: true,
              ),
            ],
          );
        }
      },
    );
  }
}
