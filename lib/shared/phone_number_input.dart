import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberInput extends StatelessWidget {
  const PhoneNumberInput({
    Key? key,
    required TextEditingController phoneNumberController,
  }) : _phoneNumberController = phoneNumberController, super(key: key);

  final TextEditingController _phoneNumberController;

  @override
  Widget build(BuildContext context) {

    return InternationalPhoneNumberInput(
      onInputChanged: (PhoneNumber number) {
      },
      selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.DIALOG,
          showFlags: false
      ),
      ignoreBlank: false,
      autoValidateMode: AutovalidateMode.disabled,
      initialValue: PhoneNumber(isoCode: 'LT'),
      textFieldController: _phoneNumberController,
      formatInput: false,
      keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
      inputBorder: const OutlineInputBorder(),
    );
  }
}