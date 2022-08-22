import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sapsak/models/sports_plan.dart';
import 'package:sapsak/providers/client_provider.dart';
import 'package:sapsak/providers/sports_plan_list_provider.dart';

import '../models/client.dart';
import 'edit_sports_plan.dart';

class SportsPlanListScreen extends StatelessWidget {
  const SportsPlanListScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Client? client = context.read<ClientProvider>().selectedClient;

    if (client != null) {
      return Scaffold(

          /// APP BAR
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text('Sports plan list of ${client.name} ${client.surname}'),
            centerTitle: true,
          ),
          body: StreamBuilder(
            stream: context.watch<SportsPlanProvider>().getAllSportsPlans(),
            builder: (BuildContext context,
                AsyncSnapshot<List<SportsPlan>> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingAnimationWidget.fourRotatingDots(
                    color: Theme.of(context).colorScheme.primary, size: 30);
              }

              if (snapshot.hasData) {

                var items = snapshot.data as List<SportsPlan>;

                return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: items[index].isDraft
                            ? const Icon(Icons.drafts_rounded)
                            : null,
                        title: Text(
                            '${DateFormat('yyyy-MM-dd').format(items[index].createdAt!.toDate()).toString()} - ${DateFormat('yyyy-MM-dd').format(items[index].bestUntil!.toDate()).toString()}'),
                        onTap: () {
                          context
                              .read<SportsPlanProvider>()
                              .setSelectedSportsPlan(items[index]);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditSportsPlan(isEdit: true)));
                        },
                      );
                    });
              } else {
                return SizedBox();
              }
            },
          ));
    } else {
      return SizedBox();
    }
  }
}
