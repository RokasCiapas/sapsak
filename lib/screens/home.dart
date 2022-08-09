import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sapsak/services/client_service.dart';
import 'package:sapsak/models/client.dart';
import 'package:sapsak/screens/client_details.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final User user = FirebaseAuth.instance.currentUser!;
  final clientSearchController = TextEditingController();
  String searchQuery = '';
  Timer? _debounce;
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot<Client>> clientStream = ClientService().clientStream(searchQuery);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xff35b9d6),
          foregroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Center(child: Text('Howdy, ${user.displayName}')),
          bottom: const TabBar(
            unselectedLabelColor: Colors.white,
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.people_outline), text: 'Clients'),
              Tab(icon: Icon(Icons.ac_unit)),
            ],
          ),
        ),
        body: TabBarView(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: clientStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingAnimationWidget.fourRotatingDots(color: Theme
                        .of(context)
                        .primaryColor, size: 30);
                  }

                  return Column(
                    children: [
                      Expanded(
                        flex: 0,
                        child: TextField(
                          autofocus: true,
                          controller: clientSearchController,
                            focusNode: focusNode,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'Search a client by name',
                              suffixIcon: clientSearchController.text.isNotEmpty ? IconButton(
                                  icon: const Icon(Icons.clear),
                                onPressed: () {
                                    setState(() {
                                      clientSearchController.text = '';
                                      searchQuery = '';
                                    });
                                },
                              ) : const SizedBox()
                          ),
                          onChanged: (val) {
                            if (_debounce?.isActive ?? false) _debounce?.cancel();
                            _debounce = Timer(const Duration(milliseconds: 300), () {
                              setState(() {
                                searchQuery = val;
                              });
                            });

                          },
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: ListView(
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Client client =
                              document.data()! as Client;
                              return ListTile(
                                leading: CircleAvatar(
                                    backgroundColor: const Color(0xff176087),
                                    child: Text(client.name[0] + client.surname[0],
                                      style: const TextStyle(
                                          color: Colors.white),)),
                                title: Text('${client.name} ${client.surname}',
                                  style: const TextStyle(color: Colors.white),),
                                tileColor: const Color(0xff35b9d6),
                                onTap: () =>
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            ClientDetails(client: client))),
                              );
                            })
                                .toList()
                                .cast(),
                          )
                      )
                    ],
                  );
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