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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: sportsPlan.sportsDays.map((SportsDay day) {
          Map<int, Multiset> multisets = day.multisets;
          List<TableRow> rows = [
            const TableRow(
                children: [
                  Padding(padding: EdgeInsets.all(5), child: Text('Muscle group'),),
                  Padding(padding: EdgeInsets.all(5), child: Text('Exercise'),),
                  Padding(padding: EdgeInsets.all(5), child: Text('Sets'),),
                  Padding(padding: EdgeInsets.all(5), child: Text('Weight'),),
                ]
            ),
          ];

          for (var m in multisets.values) {
            List<Exercise> multiset = m.multiset;

            rows.add(TableRow(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: multiset.map((e) {
                      return Padding(padding: const EdgeInsets.all(5), child: Text(e.muscleGroup));
                    }).toList(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: multiset.map((e) {
                      return Padding(padding: const EdgeInsets.all(5), child: Text(e.name));
                    }).toList(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: multiset.map((e) {
                      return Padding(padding: const EdgeInsets.all(5), child: Text('${e.setCount}x${e.repCount}'));
                    }).toList(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: multiset.map((e) {
                      return Padding(padding: const EdgeInsets.all(5), child: Text(e.weight));
                    }).toList(),
                  )
                ])
            );
          }

          return Table(
            columnWidths: const {
              0: FixedColumnWidth(74),
              1: FlexColumnWidth(3),
              2: FixedColumnWidth(42),
              3: FixedColumnWidth(60),
            },
            border: TableBorder(
              top: BorderSide(color: Theme.of(context).colorScheme.secondary),
              bottom: BorderSide(color: Theme.of(context).colorScheme.secondary),
              right: BorderSide(color: Theme.of(context).colorScheme.secondary),
              left: BorderSide(color: Theme.of(context).colorScheme.secondary),
              horizontalInside: BorderSide(color: Theme.of(context).colorScheme.secondary),
              verticalInside: BorderSide(color: Theme.of(context).colorScheme.secondary),
            ),
            children: rows,
          );
        }).toList(),
      ),
    );
  }
}
