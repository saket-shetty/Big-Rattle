import 'package:BigRattle/Data/ButtonData.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {

  final ButtonData data;
  LoginButton({this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 50.0,
      child: Material(
        borderRadius: BorderRadius.circular(25.0),
        color: this.data.color,
        shadowColor: Colors.lightBlue.withOpacity(0.8),
        elevation: 7.0,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Icon(
                this.data.icon,
                size: 25.0,
                color: Colors.white,
              ),
              new VerticalDivider(
                color: Colors.black,
                width: 22.0,
              ),
              new Text(
                this.data.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}