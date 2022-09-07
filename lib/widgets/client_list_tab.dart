import 'package:flutter/material.dart';

import '../models/client.dart';
import 'client_list.dart';
import 'client_search.dart';

class ClientListTab extends StatelessWidget {
  const ClientListTab({
    Key? key,
    required this.onNavigate,
  }) : super(key: key);

  final Function(Client) onNavigate;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Expanded(
            flex: 0,
            child: ClientSearch()
        ),
        ClientList(
          onNavigate: (client) {
            onNavigate(client);
          },
        ),
      ],
    );
  }


}
