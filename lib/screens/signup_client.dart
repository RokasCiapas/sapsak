import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sapsak/Screens/home.dart';
import 'package:sapsak/models/client.dart';
import 'package:sapsak/screens/login.dart';
import 'package:sapsak/services/client_service.dart';
import 'package:sapsak/shared/input.dart';
import 'package:sapsak/shared/logo.dart';

import '../shared/button.dart';
import '../shared/phone_number_input.dart';

class SignUpClient extends StatefulWidget {
  const SignUpClient({Key? key})
      : super(key: key);

  @override
  State<SignUpClient> createState() => _SignUpClientState();
}

class _SignUpClientState extends State<SignUpClient> {
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  bool _marketingController = true;
  final _healthIssuesController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  var nameEmptySnackBar = const SnackBar(
    content: Text('The name field must be filled!'),
  );

  var surnameEmptySnackBar = const SnackBar(
    content: Text('The surname field must be filled!'),
  );

  var birthEmptySnackBar = const SnackBar(
    content: Text('The birth date field must be filled!'),
  );

  var phoneNumberEmptySnackBar = const SnackBar(
    content: Text('The phone number field must be filled!'),
  );

  var passwordMatchSnackBar = const SnackBar(
    content: Text('The password in not match with confirm password'),
  );

  var passwordAndConfirmPasswordEmptySnackBar = const SnackBar(
    content: Text('The Password & Confirm Password fields must fill!'),
  );

  var confirmPasswordEmptySnackBar = const SnackBar(
    content: Text('The Confirm Password field must be filled!'),
  );

  var passwordEmptySnackBar = const SnackBar(
    content: Text('The Password field must be filled!'),
  );

  var emailEmptySnackBar = const SnackBar(
    content: Text('The Email field must be filled!'),
  );

  var allEmptySnackBar = const SnackBar(
    content: Text('You must fill all fields'),
  );

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _birthDateController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _healthIssuesController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Logo(),
                  const SizedBox(
                    height: 100,
                  ),
                  Input(
                    controller: _nameController,
                    hintText: 'Name',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Input(
                    controller: _surnameController,
                    hintText: 'Surname',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextField(
                      controller: _birthDateController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Birth date',
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context, initialDate: DateTime.now(),
                            firstDate: DateTime(1950), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2101)
                        );

                        if(pickedDate != null ){
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            _birthDateController.text = formattedDate; //set output date to TextField value.
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(width: 345, child: PhoneNumberInput(phoneNumberController: _phoneNumberController)),
                  const SizedBox(
                    width: 15,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Input(
                    controller: _healthIssuesController,
                    maxLines: 3,
                    hintText: 'Health issues',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Input(
                    controller: _emailController,
                    hintText: 'Email',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Input(
                    hideValue: true,
                    controller: _passwordController,
                    hintText: 'Password',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Input(
                    hideValue: true,
                    controller: _confirmPasswordController,
                    hintText: 'Confirm Password',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: CheckboxListTile(
                        title: const Text('Allow marketing'),
                        value: _marketingController,
                        onChanged: (value) => {
                          _marketingController = value!,

                        }
                    ),
                  ),
                  Button(
                    onClick: signUp,
                    text: 'Sign Up',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
                      child: const Text.rich(
                        TextSpan(
                            text: "Have an account?",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                  text: " Log in")
                            ]
                        ),
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future signUp() async {
    if (_nameController.text.isNotEmpty &
    _surnameController.text.isNotEmpty &
    _birthDateController.text.isNotEmpty &
    _phoneNumberController.text.isNotEmpty &
    _emailController.text.isNotEmpty &
    _passwordController.text.isNotEmpty &
    _confirmPasswordController.text.isNotEmpty) {
      if (passwordConfirmed()) {
        Client client;
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ).then((UserCredential data) => {
          data.user!.updateDisplayName(_nameController.text).then((value) =>
          {
            client = Client(
                firstLogin: Timestamp.fromDate(DateTime.now()),
                name: _nameController.text,
                surname: _surnameController.text,
                email: _emailController.text,
                phoneNumber: _phoneNumberController.text,
                birthday: Timestamp.fromDate(DateTime.parse(_birthDateController.text)),
                acceptMarketing: _marketingController,
                healthIssues: _healthIssuesController.text
            ),
            ClientService().addClient(data.user!.uid, client).then((value) => Navigator.of(context)
                .push(MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            )),
            ),
          }),
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(passwordMatchSnackBar);
      }
    } else if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(nameEmptySnackBar);
    }
    else if (_surnameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(surnameEmptySnackBar);
    }
    else if (_birthDateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(birthEmptySnackBar);
    }
    else if (_phoneNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(birthEmptySnackBar);
    }
    else if (_passwordController.text.isEmpty &
    _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(passwordAndConfirmPasswordEmptySnackBar);
    }
    else if (_confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(confirmPasswordEmptySnackBar);
    }
    else if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(passwordEmptySnackBar);
    }
    else if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(emailEmptySnackBar);
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(allEmptySnackBar);
    }
  }

}
