import 'package:flutter/material.dart';
import 'package:sapsak/models/client.dart';
import 'package:intl/intl.dart';
import 'package:sapsak/models/sports_plan.dart';
import 'package:sapsak/screens/edit_sports_plan.dart';
import 'package:sapsak/screens/sports_plan_list.dart';

class ClientDetails extends StatelessWidget {
  const ClientDetails({
    Key? key,
    required this.client,
  }) : super(key: key);

  final Client client;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text('${client.name} ${client.surname}')
      ),
      body: Column(
          children: [
            SizedBox(
                height: 50,
                child: Row(
                  children: [
                    const Expanded(child: Padding(padding: EdgeInsets.only(left: 20.0), child: Text('Birth date'),)),
                    Expanded(child: Text(client.birthday.toDate().toString(),)),
                  ],
                )
            ),
            SizedBox(
                height: 50,
                child: Row(children: [
                  const Expanded(child: Padding(padding: EdgeInsets.only(left: 20.0), child: Text('Email'),)),
                  Expanded(child: Text(client.email)),
                ],)
            ),
            SizedBox(
                height: 50,
                child: Row(children: [
                  const Expanded(child: Padding(padding: EdgeInsets.only(left: 20.0), child: Text('Phone number'),)),
                  Expanded(child: Text(client.phoneNumber.toString())),
                ],)
            ),
            SizedBox(
                height: 50,
                child: Row(children: [
                  const Expanded(child: Padding(padding: EdgeInsets.only(left: 20.0), child: Text('HealthIssues'),)),
                  Expanded(child: Text(client.healthIssues != null ? client.healthIssues.toString() : '-')),
                ],)
            ),
            SizedBox(
                height: 50,
                child: Row(children: [
                  const Expanded(child: Padding(padding: EdgeInsets.only(left: 20.0), child: Text('First Login'),)),
                  Expanded(child: Text(DateFormat('yyyy-MM-dd hh:mm').format(client.firstLogin.toDate()).toString())),
                ],)
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(w / 1.1, h / 15)),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SportsPlanListScreen(client: client))),
                child: const Text("View all sports plans"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(w / 1.1, h / 15)),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EditSportsPlan(client: client, sportsPlan: defaultSportsPlan))),
                child: const Text("Create sports plan"),
              ),
            )
          ]
      ),
    );
  }
}