import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sapsak/screens/login.dart';
import 'package:sapsak/shared/input.dart';

import '../shared/button.dart';
import '../shared/logo.dart';

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: Center(
            child: SizedBox(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 200,
                    ),
                    const Logo(),
                    const SizedBox(
                      height: 100,
                    ),
                    Input(
                      controller: _emailController,
                      hintText: 'Email',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Button(
                      onClick: resetPassword,
                      text: 'Reset Password',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                          const LoginScreen(),
                        ),
                      ),
                      child: const Text(
                        "Have an account? Log in",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim()).then((value) {
        /// Showing Message That user enters email correctly and reset password will be sent
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Password reset link sent! Check your Email"),
        ));
      });

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
}
