import 'package:BigRattle/Components/ImageView.dart';
import 'package:BigRattle/LocalDataStorage/SharedPreferenceData.dart';
import 'package:BigRattle/LoginFunctionality/SignInGoogle.dart';
import 'package:BigRattle/Pages/Login.dart';
import 'package:BigRattle/Tabs/Explore.dart';
import 'package:BigRattle/Tabs/TopHeadline.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  TabController _tabController;
  String name;

  SharedPreferenceData preferenceData = new SharedPreferenceData();
  SignInGoogle googleController = new SignInGoogle();

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    getUserName();
    super.initState();
  }

  getUserName() async {
    var data = await preferenceData.getUserName();
    setState(() {
      name = data;
    });
  }

  handleLogOut() {
    preferenceData.removeSession();
    googleController.handleGoogleSignOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Homepage"),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
          bottom: TabBar(
            tabs: [
              Tab(text: "Top Headline"),
              Tab(text: "Explore"),
            ],
            controller: _tabController,
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              ImageView(),
              ListTile(
                title: new Text("Log Out"),
                onTap: handleLogOut,
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TopHeadline(),
            Explore(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}
