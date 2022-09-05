import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sapsak/models/sports_plan.dart';
import 'package:sapsak/providers/client_provider.dart';
import 'package:sapsak/models/client.dart';
import 'package:sapsak/providers/sports_plan_list_provider.dart';
import 'package:sapsak/screens/client_details.dart';
import 'package:sapsak/screens/sports_plan_overview.dart';

import '../services/auth_service.dart';
import '../widgets/client_list_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final User user = FirebaseAuth.instance.currentUser!;
  final clientSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    final Stream<QuerySnapshot<Client>> clientStream = context.watch<ClientProvider>().clientList;
    final Stream<List<SportsPlan>> sportsPlanListByUser = context.watch<SportsPlanProvider>().getAllSportsPlansForOwner(AuthService().currentUser!.email!);

    Future<bool> isCoach = AuthService().isCoach();

    return FutureBuilder(
        future: isCoach,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            bool? isCoach = snapshot.data;

            if (isCoach == true) {
              return DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    title: Center(
                        child: Text('Howdy, ${user.displayName}')
                    ),
                    bottom: TabBar(
                      indicatorColor: Theme.of(context).colorScheme.primary,
                      tabs: const [
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
            } else {
              return Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    title: Center(
                        child: Text('Howdy, ${user.displayName}')
                    ),
                  ),
                body: StreamBuilder(
                  stream: sportsPlanListByUser,
                  builder: (BuildContext context, AsyncSnapshot<List<SportsPlan>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: LoadingAnimationWidget.fourRotatingDots(
                              color: Theme.of(context).colorScheme.primary,
                              size: 30
                          )
                      );
                    }

                    var list = snapshot.data as List<SportsPlan>;

                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, index) {
                          SportsPlan item = list[index];
                          return ListTile(
                              title: Text(item.goal),
                            onTap: () {
                              context
                                  .read<SportsPlanProvider>()
                                  .setSelectedSportsPlan(item);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const SportsPlanOverview()));
                            },
                          );
                        },
                      );
                    }
                    else {
                      return const Text('Something went wrong');
                    }
                  }
                ),
              );
            }

          } else {
            return const Text('Something went wrong');
          }

        });
  }

  @override
  void dispose() {
    clientSearchController.dispose();
    super.dispose();
  }

}
