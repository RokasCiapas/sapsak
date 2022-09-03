import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.text,
    required this.onClick,
  }) : super(key: key);

  final String text;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
          minimumSize: const Size(35, 35)),
      onPressed: () {
        onClick();
      },
      child: Text(text),
    );
  }
}