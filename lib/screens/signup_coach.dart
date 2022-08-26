import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapsak/Screens/home.dart';
import 'package:sapsak/screens/login.dart';
import 'package:sapsak/shared/input.dart';

import '../shared/button.dart';

class SignUpCoach extends StatefulWidget {
  const SignUpCoach({Key? key})
      : super(key: key);

  @override
  State<SignUpCoach> createState() => _SignUpCoachState();
}

class _SignUpCoachState extends State<SignUpCoach> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  var uSnackBar = const SnackBar(
    content: Text('The username field must be filled!'),
  );
  var aSnackBar = const SnackBar(
    content: Text('The password in not match with confirm password'),
  );

  var bSnackBar = const SnackBar(
    content: Text('The Password & Confirm Password fields must fill!'),
  );

  var cSnackBar = const SnackBar(
    content: Text('The Confirm Password field must be filled!'),
  );

  var dSnackBar = const SnackBar(
    content: Text('The Password field must be filled!'),
  );

  var eSnackBar = const SnackBar(
    content: Text('The Email & Confirm Password fields must be filled!'),
  );

  var fSnackBar = const SnackBar(
    content: Text('The Email field must be filled!'),
  );

  var gSnackBar = const SnackBar(
    content: Text('The Email & Password fields must be filled!'),
  );

  var xSnackBar = const SnackBar(
    content: Text('You must fill all fields'),
  );

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
    } else if (_usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(bSnackBar);
    }
    else if (_emailController.text.isNotEmpty &
    _passwordController.text.isEmpty &
    _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(bSnackBar);
    }
    else if (_emailController.text.isNotEmpty &
    _passwordController.text.isNotEmpty &
    _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(cSnackBar);
    }
    else if (_emailController.text.isNotEmpty &
    _passwordController.text.isEmpty &
    _confirmPasswordController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(dSnackBar);
    }
    else if (_emailController.text.isEmpty &
    _passwordController.text.isNotEmpty &
    _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(eSnackBar);
    }
    else if (_emailController.text.isEmpty &
    _passwordController.text.isNotEmpty &
    _confirmPasswordController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(fSnackBar);
    }
    else if (_emailController.text.isEmpty &
    _passwordController.text.isEmpty &
    _confirmPasswordController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(gSnackBar);
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(xSnackBar);
    }
  }

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
    _usernameController.dispose();
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
                    child: SvgPicture.asset('assets/images/logo.svg'),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Input(
                    controller: _usernameController,
                    hintText: 'Username',
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
                  Button(
                    onClick: signUp,
                    text: 'Sign Up',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
                    child: const Text("Have an account? Log in",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}