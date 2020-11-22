import 'package:BigRattle/Components/LoginButton.dart';
import 'package:BigRattle/Data/ButtonData.dart';
import 'package:BigRattle/LoginFunctionality/SignInGoogle.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  SignInGoogle google = new SignInGoogle();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Login',
          ),
        ),
        body: Center(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Big Rattle",
                  style:
                      TextStyle(color: Colors.deepPurpleAccent, fontSize: 32.0),
                ),
                InkWell(
                  onTap: () {
                    google.handleGoogleSignIn(context);
                  },
                  child: LoginButton(
                    data: new ButtonData(
                      'Google',
                      Colors.redAccent,
                      LineIcons.google,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
