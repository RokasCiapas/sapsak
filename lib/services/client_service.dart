import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sapsak/models/client.dart';
import 'dart:developer';

class ClientService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final CollectionReference<Client> collection = FirebaseFirestore.instance.collection('clients')
      .withConverter(
      fromFirestore: Client.fromFirestore,
      toFirestore: (Client client, options) =>
          client.toFirestore()
  );

  Stream<QuerySnapshot<Client>> clientStream() {
    inspect(collection);
    return collection.snapshots();
  }

  void addClient(Client client) {
    collection.add(client);
  }

}