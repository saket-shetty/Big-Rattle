import 'package:BigRattle/Components/NewsTileUI.dart';
import 'package:BigRattle/Data/NewsTileData.dart';
import 'package:flutter/material.dart';

class NewsListView extends StatelessWidget {
  final List<NewsTileData> list;
  NewsListView({this.list});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (_, index) {
            return NewsTileUI(
              data: new NewsTileData(
                  list[index].imageUrl,
                  list[index].headline,
                  list[index].description,
                  list[index].author,
                  list[index].date),
            );
          },
        ),
      ),
    );
  }
}
