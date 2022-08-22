import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapsak/providers/client_provider.dart';
import 'package:sapsak/models/client.dart';
import 'package:sapsak/screens/client_details.dart';

import '../widgets/client_list_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final User user = FirebaseAuth.instance.currentUser!;
  final clientSearchController = TextEditingController();
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot<Client>> clientStream = context.watch<ClientProvider>().clientList;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
              child: Text('Howdy, ${user.displayName}')
          ),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.people_outline),
                  text: 'Clients'
              ),
              Tab(icon: Icon(Icons.ac_unit)),
            ],
          ),
        ),
        body: TabBarView(
            children: [
              ClientListTab(
                clientStream: clientStream,
                clientSearchController: clientSearchController,
                onNavigate: (client) {
                  context.read<ClientProvider>().selectClient(client);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ClientDetails()
                      )
                  );
                }, onSearch: () {
                setState(() {

                });
              }, onClearSearch: () {
                setState(() {

                });
              },
              ),
              const Text('Coming'),
            ]

        ),
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

}
