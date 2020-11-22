import 'package:BigRattle/Api/NewsApi.dart';
import 'package:BigRattle/Components/NewsListView.dart';
import 'package:BigRattle/Data/NewsTileData.dart';
import 'package:flutter/material.dart';
import 'package:dropdownfield/dropdownfield.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {

  final newsSourceSelected = TextEditingController();
  final searchController = TextEditingController();
  NewsApi newsApi = NewsApi();

  String selectedNewsSource = "";

  List<NewsTileData> list = [];
  List<String> newsSource = [];

  @override
  void initState() {
    super.initState();
    getAllNewsData();
    getAllNewsSource();
  }

  getAllNewsData() async {
    List<NewsTileData> dataFromApi = await newsApi.gatherAllNewsData();
    setState(() {
      list = dataFromApi;
    });
  }

  getAllNewsSource() async {
    List<String> dataFromApi = await newsApi.getAllNewsSources();
    setState((){
      newsSource=dataFromApi;
    });
  }

  getNewsOfParsedQueryAndSource(String query, String source) async{
    clearAllData();
    List<NewsTileData> data = await newsApi.getNewsOfParsedQueryAndSource(query, source);
    setState((){
      list=data;
    });
  }

  clearAllData() async {
    setState(() {
      list.clear();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            color: Colors.deepPurpleAccent,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
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
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.search,
                    size: 30.0,
                  ),
                  color: Colors.white,
                  onPressed: () {
                    getNewsOfParsedQueryAndSource(searchController.text, newsSourceSelected.text);
                  },
                )
              ],
            ),
          ),
          DropDownField(
            items: newsSource,
            controller: newsSourceSelected,
            hintText: "Select any news source",
            enabled: true,
            strict: false,
          ),
          NewsListView(list: list),
        ],
      ),
    );
  }
}
