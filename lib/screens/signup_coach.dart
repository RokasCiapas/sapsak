import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapsak/Screens/home.dart';
import 'package:sapsak/screens/login.dart';

import '../shared/button.dart';

class SignUpCoach extends StatefulWidget {
  const SignUpCoach({Key? key})
      : super(key: key);

  @override
  State<SignUpCoach> createState() => _SignUpCoachState();
}

class _SignUpCoachState extends State<SignUpCoach> {
  /// TextFields Controller
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Username is empty
  var uSnackBar = const SnackBar(
    content: Text('The username field must be filled!'),
  );
  /// Password =! ConfirmPassword
  var aSnackBar = const SnackBar(
    content: Text('The password in not match with confirm password'),
  );

  /// Password & ConfirmPassword is Empty
  var bSnackBar = const SnackBar(
    content: Text('The Password & Confirm Password fields must fill!'),
  );

  /// Confirm Password is Empty
  var cSnackBar = const SnackBar(
    content: Text('The Confirm Password field must be filled!'),
  );

  /// Password is Empty
  var dSnackBar = const SnackBar(
    content: Text('The Password field must be filled!'),
  );

  /// Email & Confirm Password is Empty
  var eSnackBar = const SnackBar(
    content: Text('The Email & Confirm Password fields must be filled!'),
  );

  /// Email is Empty
  var fSnackBar = const SnackBar(
    content: Text('The Email field must be filled!'),
  );

  /// Email & password is Empty
  var gSnackBar = const SnackBar(
    content: Text('The Email & Password fields must be filled!'),
  );

  /// All Fields Empty
  var xSnackBar = const SnackBar(
    content: Text('You must fill all fields'),
  );

  /// SIGNING UP METHOD TO FIREBASE
  Future signUp() async {
    if (_usernameController.text.isNotEmpty &
    _emailController.text.isNotEmpty &
    _passwordController.text.isNotEmpty &
    _confirmPasswordController.text.isNotEmpty) {
      if (passwordConfirmed()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ).then((data) => {
          data.user?.updateDisplayName(_usernameController.text).then((value) => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
              const HomeScreen(),
            ),
          ),)
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(aSnackBar);
      }

      /// In the below, with if statement we have some simple validate
    } else if (_usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(bSnackBar);
    }

    else if (_emailController.text.isNotEmpty &
    _passwordController.text.isEmpty &
    _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(bSnackBar);
    }

    ///
    else if (_emailController.text.isNotEmpty &
    _passwordController.text.isNotEmpty &
    _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(cSnackBar);
    }

    ///
    else if (_emailController.text.isNotEmpty &
    _passwordController.text.isEmpty &
    _confirmPasswordController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(dSnackBar);
    }

    ///
    else if (_emailController.text.isEmpty &
    _passwordController.text.isNotEmpty &
    _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(eSnackBar);
    }

    ///
    else if (_emailController.text.isEmpty &
    _passwordController.text.isNotEmpty &
    _confirmPasswordController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(fSnackBar);
    }

    ///
    else if (_emailController.text.isEmpty &
    _passwordController.text.isEmpty &
    _confirmPasswordController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(gSnackBar);
    }

    ///
    else {
      ScaffoldMessenger.of(context).showSnackBar(xSnackBar);
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

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        /// APP BAR
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text("SIGN UP"),
          centerTitle: true,
        ),

        /// Body
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 150,
                    width: 100,
                    child: SvgPicture.asset(
                        'assets/images/logo.svg',
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  /// Username TextField
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Username',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  /// Email TextField
                  TextFormField(
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
                  TextFormField(
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
                  TextFormField(
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
                  Button(
                    onClick: signUp,
                    text: 'Sign Up',
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  /// LOGIN TEXT
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
                    child: const Text("Have an account? Log in",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}