import 'package:flutter/material.dart';

import '../providers/client_provider.dart';
import 'package:provider/provider.dart';

class ClientSearch extends StatelessWidget {
  const ClientSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final clientSearchController = TextEditingController();

    return Row(
      children: [
        Expanded(
            child: TextField(
              controller: clientSearchController,
              onChanged: (x) {
                _search(context, x);
              },
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  isDense: true,
                  border: const OutlineInputBorder(),
                  hintText: 'Client name',
                  suffixIcon: clientSearchController.text.isNotEmpty ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _search(context);
                    },
                  ) : const SizedBox.shrink()
              ),
            )
        ),
        const SizedBox(
          width: 15,
        )
      ],
    );
  }

  _search(BuildContext context, [String query = '']) {
    context.read<ClientProvider>().setSearchString(query);
  }
}