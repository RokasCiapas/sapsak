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
    this.flexibleWidth = false,
    this.width = 350,
    this.isDense = false,
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
  final bool? flexibleWidth;
  final double? width;
  final bool? isDense;

  @override
  Widget build(BuildContext context) {
    double lineHeight = 50;

    bool listenForOnChange = onChanged != null;

    return SizedBox(
      width: flexibleWidth == false ? width : null,
      height: maxLines! > 1 ? lineHeight * (maxLines!.toDouble()/1.65) : lineHeight,
      child: TextFormField(
        style: isDense == true ? const TextStyle(fontSize: 15) : null,
        readOnly: readonly,
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            contentPadding: isDense == true ? const EdgeInsets.all(12) : null,
            hintText: hintText,
            isDense: isDense
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