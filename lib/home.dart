import 'package:coronapredictor/major.dart';
import 'package:coronapredictor/news.dart';
import 'package:flutter/material.dart';
import 'details.dart';


class HomeScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen>  {

  int _currentIndex=0;
  final List<Widget> _children=[
    MajorPage(),
    DetailScreen(),
    NewsScreen(),
  ];
  void onTappedBar(int index){
     setState(() {
       _currentIndex=index;
     });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            title: Text("Details"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            title: Text("News"),
          ),
        ],
      ),
    );

  }}
