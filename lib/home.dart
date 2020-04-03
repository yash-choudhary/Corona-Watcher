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
      body: IndexedStack(
        index: _currentIndex,
        children: _children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.redAccent,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            title: Text("Overview"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            title: Text("Regional"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            title: Text("News"),
          ),
        ],
      ),
    );

  }}
