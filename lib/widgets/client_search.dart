import 'package:flutter/material.dart';

class ClientSearch extends StatelessWidget {
  const ClientSearch({
    Key? key,
    required this.clientSearchController,
    required this.w,
    required this.h,
    required this.onSubmitted,
    required this.onClear,
  }) : super(key: key);

  final TextEditingController clientSearchController;
  final double w;
  final double h;
  final VoidCallback onSubmitted;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 5,
            child: TextField(
              autofocus: true,
              controller: clientSearchController,
              onSubmitted: (x) {
                onSubmitted();
              },
              decoration: InputDecoration(
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
        Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(w / 1.1, h / 15)),
              onPressed: () {
                onSubmitted();
              },
              child: const Text("Search"),
            )
        ),
      ],
    );
  }
}