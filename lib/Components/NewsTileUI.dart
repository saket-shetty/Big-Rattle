import 'package:BigRattle/Data/NewsTileData.dart';
import 'package:BigRattle/Pages/DetailedNewsPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsTileUI extends StatelessWidget {
  final NewsTileData data;
  NewsTileUI({this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailedNewsPage(data:data)));
        },
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CachedNetworkImage(
                imageUrl: this.data.imageUrl,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: 150,
                height: 100,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      this.data.headline,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                    width: MediaQuery.of(context).size.width - 170,
                  ),
                  Padding(padding: EdgeInsets.all(5.0)),
                  Text(this.data.date, overflow: TextOverflow.ellipsis),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
