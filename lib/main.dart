import 'package:flutter/material.dart';
import 'package:payt/views/locationPage.dart';
import 'package:payt/views/leaderboard.dart';
import 'package:payt/views/loginPage.dart';
import 'package:payt/views/signUpPage.dart';
import 'package:payt/views/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'models/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
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
        initialRoute: 'login_screen',
        routes: {
          // 'welcome_screen': (context) => (),
          'registration_screen': (context) => SignupPage(),
          'login_screen': (context) => LoginDemo(),
          'home_screen': (context) => HomePageUser(),
        });
  }
}
