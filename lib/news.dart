import 'package:flutter/material.dart';



class NewsScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return NewsScreenState();
  }
}
class NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("News"),
      ),
      body: Text("hello"),
    );
  }
}