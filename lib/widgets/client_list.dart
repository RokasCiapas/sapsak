import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../models/client.dart';
import '../providers/client_provider.dart';
import 'package:provider/provider.dart';
import 'client_tile.dart';

class ClientList extends StatelessWidget {
  const ClientList({
    Key? key,
    required this.onNavigate,
  }) : super(key: key);

  final Function(Client) onNavigate;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot<Client>> clientStream = context.watch<ClientProvider>().clientList;

    return StreamBuilder<QuerySnapshot>(
      stream: clientStream,
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingAnimationWidget.fourRotatingDots(
              color: Theme.of(context).colorScheme.primary,
              size: 30
          );
        }

        var list = snapshot.data!.docs;

        return Expanded(
            flex: 1,
            child: ListView.builder(
                key: Key(list.length.toString()),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {

                  var client = (list[index]).data() as Client;
                  return ClientTile(client: client, onNavigate: onNavigate);
                }

            )
        );



      },
    );
  }
}
