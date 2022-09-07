import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../models/client.dart';
import '../providers/client_provider.dart';
import 'package:provider/provider.dart';
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
