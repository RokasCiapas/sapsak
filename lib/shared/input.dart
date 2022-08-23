import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({
    Key? key,
    required this.controller,
    required this.hintText,
    this.type,
    this.hideValue = false,
    this.textInputAction,
    this.onSubmitted,
    this.onChanged,
    this.readonly = false,
    this.maxLines = 1,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final TextInputType? type;
  final TextInputAction? textInputAction;
  final bool hideValue;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final bool readonly;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    double lineHeight = 50;

    bool listenForOnChange = onChanged != null;

    return SizedBox(
      width: 350,
      height: maxLines! > 1 ? lineHeight * (maxLines!.toDouble()/1.65) : lineHeight,
      child: TextFormField(
        readOnly: readonly,
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hintText,
        ),
        textInputAction: textInputAction,
        obscureText: hideValue,
        onFieldSubmitted: (value) => onSubmitted!(value),
        onChanged: (value) {
          if(listenForOnChange) {
            onChanged!(value);
          }
        },
        maxLines: maxLines,
      ),
    );
  }
}