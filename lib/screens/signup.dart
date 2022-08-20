import 'package:flutter/material.dart';

import 'signup_client.dart';
import 'signup_coach.dart';

class SignUpScreen extends StatelessWidget {

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      /// APP BAR
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("SIGN UP"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(w / 1.1, h / 15)),
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                    const SignUpCoach(),
                  )),
              child: const Text("Coach"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(w / 1.1, h / 15)),
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                    const SignUpClient(),
                  )),
              child: const Text("Client"),
            ),
          ],
        ),
      ),
    );
  }
}