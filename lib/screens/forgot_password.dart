import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../shared/button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  /// TextField Controller
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  /// FireBase Reset Password Method
  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());

      /// Showing Message That user enters email correctly and reset password will be sent
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Password reset link sent! Check your Email"),
      ));

      /// After 2 seconds we automatically pop forgot screen
      Future.delayed(const Duration(seconds: 2), () => Navigator.pop(context));

      ///
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e);

      /// Showing Error with SnackBar if the user enter the wrong Email or Enter nothing
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        /// APPBAR
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          title: const Text("FORGOT PASSWORD"),
          centerTitle: true,
        ),

        /// Body
        body: Center(
          child: SizedBox(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 35),
                    height: 100,
                    width: 150,
                    child: SvgPicture.asset('assets/images/logo_small.svg'),
                  ),
                  const SizedBox(
                    height: 100,
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
                    height: 20,
                  ),

                  /// LOG IN BUTTON
                  Button(
                    onClick: resetPassword,
                    text: 'Reset Password',
                  ),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}