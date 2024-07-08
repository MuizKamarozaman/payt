import 'package:flutter/material.dart';
import 'package:payt/location/locationPage.dart';
import 'package:payt/leaderboard/leaderboard.dart';
import 'package:payt/user_management/loginPage.dart';
import 'package:payt/user_management/signUpPage.dart';
import 'package:payt/views/HomePage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'models/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dcdg/dcdg.dart';

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
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        initialRoute: 'login_screen',
        routes: {
          // 'welcome_screen': (context) => (),
          'registration_screen': (context) => SignupPage(),
          'login_screen': (context) => LoginDemo(),
          'home_screen': (context) => HomePageUser(),
        });
  }
}
