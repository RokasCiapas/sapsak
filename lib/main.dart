import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'auth/main_page.dart';

void main() async {

  /// initialize FireBase App
  WidgetsFlutterBinding();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Log In & Sign up Authentication with FireBase",
      home: const MainScreen(),
      theme: ThemeData(
        primaryColor: const Color(0xff35b9d6),
        textTheme: GoogleFonts.montserratTextTheme()
      )
    );
  }
}