import 'package:flutter/material.dart';
import 'package:sapsak/models/sports_plan.dart';

import '../models/exercise.dart';
import '../models/multiset.dart';
import '../models/sports_day.dart';
import '../providers/sports_plan_list_provider.dart';
import 'package:provider/provider.dart';

class SportsPlanOverview extends StatelessWidget {
  const SportsPlanOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SportsPlan sportsPlan = context.watch<SportsPlanProvider>().selectedSportsPlan;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Sports plan'),
      ),
      body: Column(
        children: sportsPlan.sportsDays.map((SportsDay day) {
          Map<int, Multiset> multisets = day.multisets;
          List<DataRow> rows = [];

          for (var m in multisets.values) {
            List<Exercise> multiset = m.multiset;

            rows.add(DataRow(
                cells: [
                  DataCell(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: multiset.map((e) {
                          return Padding(padding: const EdgeInsets.all(5), child: Text(e.muscleGroup));
                        }).toList(),
                      )
                  ),
                  DataCell(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: multiset.map((e) {
                          return Padding(padding: const EdgeInsets.all(5), child: Text(e.name));
                        }).toList(),
                      )
                  ),
                  DataCell(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: multiset.map((e) {
                          return Padding(padding: const EdgeInsets.all(5), child: Text(e.setCount.toString()));
                        }).toList(),
                      )
                  ),
                  DataCell(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: multiset.map((e) {
                          return Padding(padding: const EdgeInsets.all(5), child: Text(e.repCount.toString()));
                        }).toList(),
                      )
                  ),
                  DataCell(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: multiset.map((e) {
                          return Padding(padding: const EdgeInsets.all(5), child: Text(e.weight));
                        }).toList(),
                      )
                  ),
                ])
            );
          }

          return DataTable(
            dataRowHeight: 90,
              columns: const [
                DataColumn(label: Text('Muscle group')),
                DataColumn(label: Text('Exercise')),
                DataColumn(label: Text('Set count')),
                DataColumn(label: Text('Rep count')),
                DataColumn(label: Text('Weight')),
              ],
              rows: rows
          );
        }).toList(),
      ),
    );
  }
}
