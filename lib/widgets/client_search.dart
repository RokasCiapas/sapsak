import 'package:flutter/material.dart';

import '../shared/button.dart';

class ClientSearch extends StatelessWidget {
  const ClientSearch({
    Key? key,
    required this.clientSearchController,
    required this.onSubmitted,
    required this.onClear,
  }) : super(key: key);

  final TextEditingController clientSearchController;
  final VoidCallback onSubmitted;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextField(
              autofocus: true,
              controller: clientSearchController,
              onSubmitted: (x) {
                onSubmitted();
              },
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  isDense: true,
                  border: const OutlineInputBorder(),
                  hintText: 'Client name',
                  suffixIcon: clientSearchController.text.isNotEmpty ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      onClear();
                    },
                  ) : const SizedBox()
              ),
            )
        ),
        const SizedBox(
          width: 15,
        ),
        SizedBox(
            width: 80,
            height: 40,
            child: Button(
              onClick: () {
                onSubmitted();
              },
              text: 'Search',
            )
        ),
      ],
    );
  }
}