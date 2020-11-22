import 'package:BigRattle/Pages/Homepage.dart';
import 'package:BigRattle/Pages/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';


class SharedPreferenceData{

  //Getters

  getSessionId(BuildContext context) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String sessionId = preferences.getString('sessionID');
    if(sessionId!=null){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage()));
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
    }
  }

  getUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('username');
  }

  getUserImage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('userimage');
  }

  //Setters

  setSession(String sessionID) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('sessionID', sessionID);
  }

  setName(String name) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('username', name);
  }

  setImage(String image) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('userimage', image);
  }

  //Remove all data

  removeSession() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('sessionID');
  }
}