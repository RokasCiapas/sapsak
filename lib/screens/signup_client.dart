import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sapsak/Screens/home.dart';
import 'package:sapsak/models/client.dart';
import 'package:sapsak/screens/login.dart';
import 'package:sapsak/services/client_service.dart';

class SignUpClient extends StatefulWidget {
  const SignUpClient({Key? key})
      : super(key: key);

  @override
  State<SignUpClient> createState() => _SignUpClientState();
}

class _SignUpClientState extends State<SignUpClient> {
  /// TextFields Controller
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  bool _marketingController = true;
  final _healthIssuesController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  /// name is empty
  var nameEmptySnackBar = const SnackBar(
    content: Text('The name field must be filled!'),
  );
  /// surname is empty
  var surnameEmptySnackBar = const SnackBar(
    content: Text('The surname field must be filled!'),
  );
  /// birth date is empty
  var birthEmptySnackBar = const SnackBar(
    content: Text('The birth date field must be filled!'),
  );
  /// phone number is empty
  var phoneNumberEmptySnackBar = const SnackBar(
    content: Text('The phone number field must be filled!'),
  );
  /// Password =! ConfirmPassword
  var passwordMatchSnackBar = const SnackBar(
    content: Text('The password in not match with confirm password'),
  );

  /// Password & ConfirmPassword is Empty
  var passwordAndConfirmPasswordEmptySnackBar = const SnackBar(
    content: Text('The Password & Confirm Password fields must fill!'),
  );

  /// Confirm Password is Empty
  var confirmPasswordEmptySnackBar = const SnackBar(
    content: Text('The Confirm Password field must be filled!'),
  );

  /// Password is Empty
  var passwordEmptySnackBar = const SnackBar(
    content: Text('The Password field must be filled!'),
  );

  /// Email is Empty
  var emailEmptySnackBar = const SnackBar(
    content: Text('The Email field must be filled!'),
  );

  /// All Fields Empty
  var allEmptySnackBar = const SnackBar(
    content: Text('You must fill all fields'),
  );

  /// SIGNING UP METHOD TO FIREBASE
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

      /// In the below, with if statement we have some simple validate
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

    ///
    else if (_confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(confirmPasswordEmptySnackBar);
    }

    ///
    else if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(passwordEmptySnackBar);
    }

    ///
    else if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(emailEmptySnackBar);
    }

    ///
    else {
      ScaffoldMessenger.of(context).showSnackBar(allEmptySnackBar);
    }
  }

  /// CHECK IF PASSWORD CONFIREMD OR NOT
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
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// CURRENT WIDTH AND HEIGHT
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    ///
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        /// APP BAR
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          automaticallyImplyLeading: true,
          title: const Text("SIGN UP"),
          centerTitle: true,
        ),

        /// Body
        body: Container(
          margin: const EdgeInsets.all(17),
          width: w,
          height: h,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /// FLUTTER IMAGE
                Container(
                  margin: const EdgeInsets.only(right: 35),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/flutter.png")),
                  ),
                  height: h / 4,
                  width: w / 1.5,
                ),
                const SizedBox(
                  height: 20,
                ),

                /// TOP TEXT
                const Text(
                  "Client Sign Up To the App",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                /// name TextField
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Name',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                /// surname TextField
                TextField(
                  controller: _surnameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Surname',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                /// birth date TextField
                TextField(
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
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    /// phone number TextField
                    Expanded(
                      flex: 5,
                      child: InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                        },
                        selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.DIALOG,
                            showFlags: false
                        ),
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: const TextStyle(color: Colors.black),
                        initialValue: null,
                        textFieldController: _phoneNumberController,
                        formatInput: false,
                        keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                        inputBorder: const OutlineInputBorder(),
                      ),),
                    const SizedBox(
                      width: 15,
                    ),
                    /// allow marketing
                    Expanded(flex: 1,
                      child: CheckboxListTile(
                          title: const Text('Allow marketing'),
                          value: _marketingController,
                          onChanged: (value) => {
                            _marketingController = value!,

                          }
                      ),)
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                /// Health issues TextField
                TextField(
                  controller: _healthIssuesController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Health issues',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                /// Email TextField
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),

                /// Password TextField
                TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),

                /// Confrim Password TextField
                TextField(
                  obscureText: true,
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Confirm Password',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                /// SIGN UP BUTTON
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      minimumSize: Size(w / 1.1, h / 15)),
                  onPressed: signUp,
                  child: const Text("Sign Up"),
                ),
                const SizedBox(
                  height: 20,
                ),

                /// LOGIN TEXT
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
                  child: RichText(
                    text: TextSpan(
                        text: "Have an account?",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                              text: " Log in",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor))
                        ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}