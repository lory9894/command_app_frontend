import 'package:flutter/material.dart';

import 'package:command_app_frontend/session.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


Future<void> signInWithGoogle(BuildContext context, VoidCallback onSuccess) async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // save credential in session
  userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
  idToken = await userCredential?.user?.getIdToken();
  print(userCredential?.user?.displayName);
  print(userCredential?.user?.email);

  // on success navigate to profile
  onSuccess.call();
}

Future<void> signOutFromGoogle() async {
  await FirebaseAuth.instance.signOut();
  userCredential = null;
}