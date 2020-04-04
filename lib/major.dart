import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class MajorPage extends StatefulWidget {
  @override
  _MajorPageState createState() => _MajorPageState();
}

class _MajorPageState extends State<MajorPage> {
  String cases='...';
  String deaths='...';
  String recov='...';
  String active_cases='...';
  String new_cases='...';
  String new_deaths='...';
  bool isData = false;

  Future<void> fetchJSON() async {
    var res = await http.get(
      "https://corona-engine.herokuapp.com/stat",
      headers: {"Accept": "application/json"},
    );

    if(res.statusCode==200)
    {
      var responseBody = res.body;
      var responseJSON = json.decode(responseBody);
      cases=responseJSON['total_cases'];
      deaths=responseJSON['total_deaths'];
      recov=responseJSON['total_recovered'];
      active_cases=responseJSON['active_cases'];
      new_cases=responseJSON['new_cases'];
      new_deaths=responseJSON['new_deaths'];
      isData = true;
      setState(() {
        print('UI Updated');
      });
    }
    else
    {
      print('Something went wrong. \nResponse Code : ${res.statusCode}');
    }
  }
  @override
  void initState(){
    fetchJSON();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width;
    double height = MediaQuery. of(context). size. height;
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.red,
          elevation: 0,
          centerTitle: true,
          title: Text("Current Status",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
        body: Container(
            color: Colors.white,
            child:LiquidPullToRefresh(
              onRefresh: fetchJSON,
              showChildOpacityTransition: false,
              color: Colors.red,
              springAnimationDurationInMilliseconds: 200,
              borderWidth:2,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                children: <Widget>[
                  SizedBox(
                    height: height*0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      sumcon("Total Cases",cases,height*0.15,width*0.47,Colors.white,Colors.black,Colors.redAccent),
                      sumcon("Total Deaths",deaths,height*0.15,width*0.47,Colors.red,Colors.black45,Colors.white),

                    ],
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      sumcon("New Cases",new_cases,height*0.15,width*0.47,Colors.black,Colors.black45,Colors.yellow),
                      sumcon("New Deaths",new_deaths,height*0.15,width*0.47,Colors.red,Colors.black45,Colors.yellow),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      sumcon("Recovered",recov,height*0.15,width*0.47,Colors.white,Colors.black45,Colors.green),
                      sumcon("Active Cases",active_cases,height*0.15,width*0.47,Colors.black,Colors.black45,Colors.white),
                    ],
                  ),
//                SizedBox(
//                  width: 200.0,
//                  height: 300.0,
//                  child: WebView(
//                    initialUrl: Uri.dataFromString('<html><body><iframe style="width:100%"; width="${width}" height="${height*0.3}" src="https://coronavirus.app/map?mode=infected&embed=true" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></body></html>', mimeType: 'text/html').toString(),
//                    javascriptMode: JavascriptMode.unrestricted,
//                  )
//                ),

                ],),
            )));

  }}


Widget sumcon(num,text,height,width,tc1,tc2,box_col)  => Container(
  height: height,
  width: width,
  alignment: Alignment.center,
  decoration: BoxDecoration(
    color: box_col,
    borderRadius: BorderRadius.all(
      Radius.circular(35),
    ),
    border: Border.all(
      color: Colors.grey, //                   <--- border color
      width: 3.0,
    ),
  ),
  child: SizedBox.expand(
    child: FlatButton(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: tc1,
              fontSize: 28,
            ),
            textAlign: TextAlign.left,
          ),
          Text(num,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: tc2,
              fontSize: 20,
            ),
            textAlign: TextAlign.right,
          )
        ],
      ),
    ),
  ),
);