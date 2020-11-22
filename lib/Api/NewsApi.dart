import 'package:BigRattle/Data/NewsTileData.dart';
import 'package:BigRattle/LocalDataStorage/SQFlite.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsApi {
  String apiKey = "43269381ee56442abe4bdf6ae2d2c9a5";
  List<NewsTileData> list = [];
  int length = 0;

  final sqlHelper = SQFliteHelper.instance;

  Future<List<NewsTileData>> gatherAllNewsData() async {
    var response = await http.get(
        "https://newsapi.org/v2/top-headlines?sources=google-news,wired,the-washington-times&apiKey=$apiKey");
    if (response.statusCode == 200) {
      String responseBody = response.body;
      var responseBodyToJson = json.decode(responseBody);
      responseBodyToJson['totalResults'] > 20
          ? length = 20
          : length = responseBodyToJson['totalResults'];
      extractDatafromJson(responseBodyToJson['articles'], length);
    }
    return list;
  }

  Future<List<NewsTileData>> getDataOfSearchQuery(String query) async {
    var response = await http
        .get("https://newsapi.org/v2/top-headlines?q=$query&apiKey=$apiKey");
    if (response.statusCode == 200) {
      String responseBody = response.body;
      var responseBodyToJson = json.decode(responseBody);
      responseBodyToJson['totalResults'] > 20
          ? length = 20
          : length = responseBodyToJson['totalResults'];
        extractDatafromJson(responseBodyToJson['articles'], length);
      }
    return list;
  }

  Future<List<String>> getAllNewsSources() async{
    List<String> list = [];
    var response = await http.get("https://newsapi.org/v2/sources?apiKey=$apiKey");
    if(response.statusCode==200){
      String responseBody = response.body;
      var responseBodyToJson = json.decode(responseBody);
      for(int i=0;i<50;i++){
        var id = responseBodyToJson['sources'][i]['id'];
        // var name = responseBodyToJson['sources'][i]['name'];
        list.add(id);
      }
    }
    return list;
  }

  getNewsOfParsedQueryAndSource(String query, String source) async {
    var response = await http.get(
    "https://newsapi.org/v2/top-headlines?q=$query&sources=$source&apiKey=$apiKey");
    if (response.statusCode == 200) {
      String responseBody = response.body;
      print(responseBody);
      var responseBodyToJson = json.decode(responseBody);
      responseBodyToJson['totalResults'] > 20
          ? length = 20
          : length = responseBodyToJson['totalResults'];
        extractDatafromJson(responseBodyToJson['articles'], length);
      }
    return list;
  }

  extractDatafromJson(var json, int length) async {
    for (int index = 0; index < length; index++) {
      String image = json[index]['urlToImage'];
      String headline = json[index]['title'];
      String description = json[index]['description'];
      String author = json[index]['author'];
      String date = json[index]['publishedAt'];
      if (image != null && headline != null && description != null && author != null && date != null) {
        list.add(new NewsTileData(image,headline,description,author,date));
        // insertDataToDB(image,headline,description,author,date);
      }
    }
  }

  insertDataToDB(var image, var headline, var description, var author, var date) async {
    Map<String, dynamic> row = {
      SQFliteHelper.colImage : image,
      SQFliteHelper.colHeadline : headline,
      SQFliteHelper.colDescription : description,
      SQFliteHelper.colAuthor : author,
      SQFliteHelper.colDate : date
    };
    final id = await sqlHelper.insert(row);
    print(id);
  }
}
