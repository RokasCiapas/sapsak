import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/client.dart';
import 'client_tile.dart';

class ClientList extends StatelessWidget {
  const ClientList({
    Key? key,
    required this.list,
    required this.clientSearchController,
    required this.onNavigate,
  }) : super(key: key);

  final List<QueryDocumentSnapshot> list;
  final TextEditingController clientSearchController;
  final Function(Client) onNavigate;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          var client = (list[index]).data() as Client;
          if (client.name.toLowerCase().contains(clientSearchController.text.toLowerCase())) {
            return ClientTile(client: client, onNavigate: onNavigate);
          }
          return const SizedBox();

        }

    );
  }
}
