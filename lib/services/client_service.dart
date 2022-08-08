import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sapsak/models/client.dart';

class ClientService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final CollectionReference<Client> collection = FirebaseFirestore.instance.collection('clients')
      .withConverter(
      fromFirestore: Client.fromFirestore,
      toFirestore: (Client client, options) =>
          client.toFirestore()
  );

  Stream<QuerySnapshot<Client>> clientStream() {
    return collection.snapshots();
  }

  Future<void> addClient(String uid, Client client) {
    return collection.doc(uid).set(client);
  }

}