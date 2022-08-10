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
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot<Client>> clientStream = ClientService().clientStream();
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

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
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 5,
                                  child: TextField(
                                    autofocus: true,
                                    controller: clientSearchController,
                                    onSubmitted: (x) {
                                      setState(() {

                                      });
                                    },
                                    decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        hintText: 'Client name',
                                        suffixIcon: clientSearchController.text.isNotEmpty ? IconButton(
                                          icon: const Icon(Icons.clear),
                                          onPressed: () {
                                            setState(() {
                                              clientSearchController.clear();
                                            });
                                          },
                                        ) : const SizedBox()
                                    ),
                                  )),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Theme.of(context).primaryColor,
                                        minimumSize: Size(w / 1.1, h / 15)),
                                    onPressed: () {
                                      setState(() {});
                                    },
                                    child: const Text("Search"),
                                  )
                              ),
                            ],
                          )),
                      Expanded(
                          flex: 1,
                          child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                var client = (snapshot.data!.docs.toList()[index]).data()! as Client;
                                if (client.name.toLowerCase().contains(clientSearchController.text.toLowerCase())) {
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
                                }
                                return SizedBox();

                              }

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