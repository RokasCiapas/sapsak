import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sapsak/models/sports_plan.dart';
import 'package:sapsak/services/sports_plan_service.dart';

import '../models/client.dart';
import 'edit_sports_plan.dart';

class SportsPlanListScreen extends StatelessWidget {

  const SportsPlanListScreen(
      {
        Key? key,
        required this.client
      }) : super(key: key);

  final Client client;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot<SportsPlan>> sportsPlanStream = SportsPlanService().sportsPlanStream();

    return Scaffold(
      /// APP BAR
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          automaticallyImplyLeading: true,
          title: Text('Sports plan list of ${client.name} ${client.surname}'),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: sportsPlanStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingAnimationWidget.fourRotatingDots(color: Theme.of(context).primaryColor, size: 30);
            }

            return ListView(
              children: snapshot.data!.docs
                  .map((DocumentSnapshot document) {
                SportsPlan sportsPlan =
                document.data()! as SportsPlan;
                return ListTile(
                  title: Text(
                    '${DateFormat('yyyy-MM-dd').format(sportsPlan.createdAt.toDate()).toString()} - ${DateFormat('yyyy-MM-dd').format(sportsPlan.bestUntil.toDate()).toString()}',
                    style: const TextStyle(color: Colors.white),),
                  tileColor: const Color(0xff35b9d6),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EditSportsPlan(client: client))),
                );
              })
                  .toList()
                  .cast(),
            );

          },
        )
    );
  }
}