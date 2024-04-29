import 'package:agrimatics/providers/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welome to Agrimetics"),
            ElevatedButton.icon(
              icon: FaIcon(
                FontAwesomeIcons.google,
                color: Colors.red,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogin();
              },
              label: Text("Sign In with Google"),
            ),
          ],
        ),
      ),
    );
  }
}
