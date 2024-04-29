import 'package:agrimatics/screens/authentication/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home_screen.dart';

class HomeController extends StatelessWidget {
  const HomeController({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return const HomeScreen();
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Something Went Wrong"),
            );
          } else {
            return LoginScreen();
          }
        }),);
  }
}
