import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/client.dart';

class ClientDetailsContainer extends StatelessWidget {
  const ClientDetailsContainer({
    Key? key,
    required this.client,
  }) : super(key: key);

  final Client client;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      ],
    );
  }
}
