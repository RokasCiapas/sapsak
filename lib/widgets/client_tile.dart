import 'package:flutter/material.dart';

import '../models/client.dart';

class ClientTile extends StatelessWidget {
  const ClientTile({
    Key? key,
    required this.client,
    required this.onNavigate,
  }) : super(key: key);

  final Client client;
  final Function(Client p1) onNavigate;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
            child: Text(client.name[0] + client.surname[0])),
        title: Text('${client.name} ${client.surname}'),
        onTap: () {
          onNavigate(client);
        }
    );
  }
}
