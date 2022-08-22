import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../models/client.dart';
import 'client_list.dart';
import 'client_search.dart';

class ClientListTab extends StatelessWidget {
  const ClientListTab({
    Key? key,
    required this.clientStream,
    required this.clientSearchController,
    required this.onNavigate,
    required this.onSearch,
    required this.onClearSearch,
  }) : super(key: key);

  final Stream<QuerySnapshot<Client>> clientStream;
  final TextEditingController clientSearchController;
  final Function(Client) onNavigate;
  final VoidCallback onSearch;
  final VoidCallback onClearSearch;

  @override
  Widget build(BuildContext context) {
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

        return Column(
          children: [
            Expanded(
                flex: 0,
                child: ClientSearch(
                  clientSearchController: clientSearchController,
                  onSubmitted: () {
                    onSearch();
                  },
                  onClear: () {
                    onClearSearch();
                  },
                )
            ),
            Expanded(
                flex: 1,
                child: ClientList(
                  list: snapshot.data!.docs,
                  clientSearchController: clientSearchController,
                  onNavigate: (client) {
                    onNavigate(client);
                  },
                )
            )
          ],
        );
      },
    );
  }
}
