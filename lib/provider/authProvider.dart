import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //signout user
  Future<String> signOut() async {
    await _firebaseAuth.signOut();
    await GoogleSignIn(scopes: <String>['email']).signOut();
    return 'Successfully Signed Out';
  }

  //signIn User
  Future<UserCredential> signInWithGoogle() async {
    //start the authentication flow
    //shows list of available google accounts
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    //obtain auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    //create new Credentials
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
