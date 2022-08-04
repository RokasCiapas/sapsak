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
  final Stream<QuerySnapshot<Client>> clientStream = ClientService().clientStream();

  @override
  Widget build(BuildContext context) {

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
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingAnimationWidget.fourRotatingDots(color: Theme.of(context).primaryColor, size: 30);
                  }

                  return ListView(
                    children: snapshot.data!.docs
                        .map((DocumentSnapshot document) {
                      Client client =
                      document.data()! as Client;
                      return ListTile(
                        leading: CircleAvatar(backgroundColor: const Color(0xff176087),child: Text(client.name[0] + client.surname[0], style: const TextStyle(color: Colors.white),)),
                        title: Text('${client.name} ${client.surname}', style: const TextStyle(color: Colors.white),),
                        tileColor: const Color(0xff35b9d6),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ClientDetails(client: client))),
                      );
                    })
                        .toList()
                        .cast(),
                  );
                },
              ),
              const Text('Coming'),
            ]

        ),
      ),
    );
  }

}