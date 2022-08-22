import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/client.dart';
import '../services/client_service.dart';

class ClientProvider with ChangeNotifier, DiagnosticableTreeMixin {
  Stream<QuerySnapshot<Client>> _clientList = ClientService().clientStream();
  Client? _selectedClient = null;

  Stream<QuerySnapshot<Client>> get clientList => _clientList;

  Client? get selectedClient => _selectedClient;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    // properties.add(IntProperty('count', count));
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