import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../auth/auth_page.dart';
import '../Screens/home.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Stream<User?> session = FirebaseAuth.instanceFor(app: Firebase.app(), persistence: Persistence.SESSION).authStateChanges();

    return Scaffold(
      body: StreamBuilder<User?>(
        stream: session,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                    color: Theme.of(context).colorScheme.primary,
                    size: 30
                )
            );
          } else {
            if (snapshot.hasData) {
              return const HomeScreen();
            } else {
              return const AuthScreen();
            }
          }

        },
      ),
    );
  }
}
