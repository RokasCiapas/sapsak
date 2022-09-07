import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/client.dart';
import '../services/client_service.dart';

class ClientProvider with ChangeNotifier, DiagnosticableTreeMixin {
  final Stream<QuerySnapshot<Client>> _clientList = ClientService().clientStream();
  Client? _selectedClient;

  String _searchString = '';

  Stream<QuerySnapshot<Client>> get clientList {
    return _searchString.isEmpty ? _clientList : _clientList.where((QuerySnapshot<Client> querySnapshot) {
      return querySnapshot.docs.where((QueryDocumentSnapshot<Client> doc) {
        return doc.data().name.toLowerCase().contains(_searchString.toLowerCase());
      }).isNotEmpty;

    });
  }

  Client? get selectedClient => _selectedClient;

  void setSearchString(String query) {
    _searchString = query;
    notifyListeners();
  }

  void selectClient(Client client) {
    _selectedClient = client;
    notifyListeners();
  }

  void unselectClient() {
    _selectedClient = null;
    notifyListeners();
  }
}