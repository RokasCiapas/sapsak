import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapsak/models/client.dart';
import 'package:sapsak/providers/client_provider.dart';
import 'package:sapsak/providers/sports_plan_list_provider.dart';
import 'package:sapsak/screens/edit_sports_plan.dart';
import 'package:sapsak/screens/sports_plan_list.dart';

import '../shared/button.dart';
import '../widgets/client_details_container.dart';

class ClientDetails extends StatelessWidget {
  const ClientDetails({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final Client? client = context.watch<ClientProvider>().selectedClient;

    if (client != null) {
      return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text('${client.name} ${client.surname}')
        ),
        body: Column(
            children: [
              ClientDetailsContainer(client: client),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Button(
                  onClick: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SportsPlanListScreen())),
                  text: 'View all sports plans',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Button(
                    onClick: () {
                      context.read<SportsPlanProvider>().resetSelectedSportsPlan();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const EditSportsPlan()));
                    },
                    text: 'Create sports plan'
                ),
              )
            ]
        ),
      );
    } else {
      return SizedBox();
    }
  }
}

