import 'package:BigRattle/Api/NewsApi.dart';
import 'package:BigRattle/Components/NewsListView.dart';
import 'package:BigRattle/Data/NewsTileData.dart';
import 'package:flutter/material.dart';

class TopHeadline extends StatefulWidget {
  @override
  _TopHeadlineState createState() => _TopHeadlineState();
}

class _TopHeadlineState extends State<TopHeadline> {
  TextEditingController searchController = new TextEditingController();
  NewsApi newsApi = new NewsApi();

  List<NewsTileData> list = [];

  @override
  void initState() {
    super.initState();
    getAllNewsData();
  }

  getAllNewsData() async {
    List<NewsTileData> dataFromApi = await newsApi.gatherAllNewsData();
    setState(() {
      list = dataFromApi;
    });
  }

  clearAllData() async {
    setState(() {
      list.clear();
    });
  }

  getNewsOfParsedQuery() async {
    clearAllData();
    List<NewsTileData> dataFromApi =
        await newsApi.getDataOfSearchQuery(searchController.text);
    setState(() {
      list = dataFromApi;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        new Container(
          color: Colors.deepPurpleAccent,
          width: MediaQuery.of(context).size.width,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                width: MediaQuery.of(context).size.width - 50,
                height: 40.0,
                child: new TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: searchController,
                  style: new TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: new TextStyle(color: Colors.white),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  ),
                ),
              ),
              new IconButton(
                icon: new Icon(
                  Icons.search,
                  size: 30.0,
                ),
                color: Colors.white,
                onPressed: () {
                  getNewsOfParsedQuery();
                },
              )
            ],
          ),
        ),
        //News UI Tile
        NewsListView(list: list),
      ],
    );
  }
}
