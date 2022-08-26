import 'package:flutter/material.dart';

import '../shared/button.dart';
import 'signup_client.dart';
import 'signup_coach.dart';

class SignUpScreen extends StatelessWidget {

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      /// APP BAR
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Button(
              onClick: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                    const SignUpCoach(),
                  )),
              text: 'Coach',
            ),
            const SizedBox(
              height: 20,
            ),
            Button(
              onClick: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                    const SignUpClient(),
                  )
              ),
              text: 'Client',
            ),
          ],
        ),
      ),
    );
  }
}