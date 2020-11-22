import 'package:BigRattle/LocalDataStorage/SharedPreferenceData.dart';
import 'package:BigRattle/Pages/Homepage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInGoogle{
  FirebaseAuth _fAuth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = new GoogleSignIn();

  SharedPreferenceData sharedPreferenceData = new SharedPreferenceData();

  Future handleGoogleSignIn(BuildContext context) async{
    try{
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gSA.accessToken,
        idToken: gSA.idToken,
      );
      User googleuser = (await _fAuth.signInWithCredential(credential)).user;

      
      sharedPreferenceData.setSession(googleuser.uid);
      sharedPreferenceData.setName(googleuser.displayName);
      sharedPreferenceData.setImage(googleuser.photoURL);
      
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage()));
    }catch (error){
      print(error);
    }
  }

  handleGoogleSignOut() {
    _googleSignIn.signOut();
  }
  
}