import 'package:BigRattle/LocalDataStorage/SharedPreferenceData.dart';
import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  SharedPreferenceData sessionKey = new SharedPreferenceData();

  String imageUrl =
      "https://avatars0.githubusercontent.com/u/31775521?s=460&v=4";
  String name = "temp";

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    var data = await sessionKey.getUserImage();
    var dataName = await sessionKey.getUserName();
    setState(() {
      imageUrl = data;
      name = dataName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurpleAccent,
      child: Column(
        children: [
          DrawerHeader(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(imageUrl), fit: BoxFit.fill),
              ),
            ),
          ),
          Text(
            '$name',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w400,
              fontFamily: 'Montserrat',
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
