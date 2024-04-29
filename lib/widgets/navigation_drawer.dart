import 'package:agrimatics/providers/google_sign_in.dart';
import 'package:agrimatics/providers/language_provider.dart';
import 'package:agrimatics/screen_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';

class CustomNavigationDrawer extends StatefulWidget {
  const CustomNavigationDrawer({super.key});

  @override
  State<CustomNavigationDrawer> createState() => _CustomNavigationDrawerState();
}

class _CustomNavigationDrawerState extends State<CustomNavigationDrawer> {


  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Engilsh"), value: "English"),
      DropdownMenuItem(child: Text("Hindi"), value: "Hindi"),
      DropdownMenuItem(child: Text("Tamil"), value: "Tamil",)
    ];
    return menuItems;
  }

  String selectedValue = "English";

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Color(0xFF51bd7c),
              padding: EdgeInsets.only(
                  top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user.photoURL!),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "${user.displayName}",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text("Home"),
              onTap: () {
                Navigator.pushReplacementNamed(context, homeScreen);
              },
            ),
            ListTile(
              title: Text("Store"),
              onTap: () {
                Navigator.pushNamed(context, storeScreen);
              },
            ),
            ListTile(
              title: Text("Disease Detection"),
              onTap: () {
                Navigator.pushNamed(context, diseaseDetection);
              },
            ),
            ListTile(
              title: Text("Crop Recommendation"),
              onTap: () {
                Navigator.pushNamed(context, cropRecommendation);
              },
            ),
            ListTile(
              title: Text("Weather Information"),
              onTap: () {
                Navigator.pushNamed(context, weatherDataScreen);
              },
            ),
            ListTile(
              title: Text("Crop Information"),
              onTap: () {
                Navigator.pushNamed(context, cropInformation);
              },
            ),
            ListTile(
              title: Text("Community"),
              onTap: () {
                Navigator.pushNamed(context, communityScreen);
              },
            ),
            ListTile(
              title: Text("Rent an Item"),
              onTap: () {
                Navigator.pushNamed(context, rentScreen);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0),
              child: DropdownButton(
                style: TextStyle(fontWeight: FontWeight.normal,color: Colors.black,fontSize: 16),
                underline: const SizedBox(),
                items: dropdownItems,
                value: selectedValue, onChanged: (String? value) async {

                  final provider = Provider.of<LanguageProvider>(context,listen: false);
                  String hello = "Hello";
                  if(value=="Hindi") {
                    provider.translate(hello, 'hi');
                  }else if(value == "English"){
                    provider.translate(hello, 'en');
                  }else if(value=="Tamil"){
                    provider.translate(hello, 'ta');
                  }
                  //Here we can do the changes
                  setState(() {
                    selectedValue = value!;
                  });
              },
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text("Log Out"),
              onTap: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
