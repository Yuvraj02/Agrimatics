import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {

  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user=> _user!;

  Future googleLogin() async {

   try {
     final googleUser = await googleSignIn.signIn();

     if (googleUser == null) return;
     _user = googleUser;

     final googleAuth = await googleUser.authentication;

     final credential = GoogleAuthProvider.credential(
       accessToken: googleAuth.accessToken,
       idToken: googleAuth.idToken,
     );

    UserCredential userCredential =  await FirebaseAuth.instance.signInWithCredential(credential);

    User? user = userCredential.user;

    if(user!=null){
      if(userCredential.additionalUserInfo!.isNewUser){
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'username' : user.displayName,
          'uid' : user.uid,
          'profilePhoto' : user.photoURL,
        });
      }
    }

   }catch (e){
     print(e.toString());
   }
    notifyListeners();
  }

  Future logout() async{
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

}