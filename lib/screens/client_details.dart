import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapsak/models/client.dart';
import 'package:intl/intl.dart';
import 'package:sapsak/providers/client_provider.dart';
import 'package:sapsak/providers/sports_plan_list_provider.dart';
import 'package:sapsak/screens/edit_sports_plan.dart';
import 'package:sapsak/screens/sports_plan_list.dart';

import '../widgets/client_details_container.dart';

class ClientDetails extends StatelessWidget {
  const ClientDetails({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final Client? client = context.watch<ClientProvider>().selectedClient;

    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(w / 1.1, h / 15)),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SportsPlanListScreen())),
                  child: const Text("View all sports plans"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(w / 1.1, h / 15)),
                  onPressed: () {
                    context.read<SportsPlanProvider>().resetSelectedSportsPlan();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const EditSportsPlan()));
                  },
                  child: const Text("Create sports plan"),
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
