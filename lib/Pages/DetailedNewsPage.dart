import 'package:BigRattle/Data/NewsTileData.dart';
import 'package:flutter/material.dart';

class DetailedNewsPage extends StatelessWidget {
  final NewsTileData data;
  DetailedNewsPage({this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Big Rattle",
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: new EdgeInsets.only(top: 0),
        child: new Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 250,
                child: new Image(
                  image: NetworkImage('${this.data.imageUrl}'),
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: new Text(
                  '${this.data.headline}',
                  style: new TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.all(03.0),
              ),
              new Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: new Text(
                    '${this.data.description}',
                    style: new TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.only(bottom: 10.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
