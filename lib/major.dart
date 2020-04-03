import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class MajorPage extends StatefulWidget {
  @override
  _MajorPageState createState() => _MajorPageState();
}

class _MajorPageState extends State<MajorPage> {
  String cases="0";
  String deaths="0";
  String recov="0";
  String active_cases="0";
  String new_cases="0";
  String new_deaths="0";
  bool isData = false;

  fetchJSON() async {
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
        backgroundColor: Colors.blue,
        elevation: 5,
        centerTitle: true,
        title: Text("Overview",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
    body: Stack(
    children:<Widget>[
    ListView(
    scrollDirection: Axis.vertical,
    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
    children: <Widget>[
    SizedBox(
    height: height*0.10,
    ),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
    sumcon("Total Cases",cases,height*0.15,width*0.45,Colors.redAccent,Colors.blueGrey[900]),
    sumcon("New Cases",new_cases,height*0.15,width*0.45,Colors.black,Colors.blueGrey[900]),
    ],
    ),

    SizedBox(
    height: 30,
    ),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
    sumcon("Total Deaths",deaths,height*0.15,width*0.45,Colors.black,Colors.blueGrey[900]),
    sumcon("New Deaths",new_deaths,height*0.15,width*0.45,Colors.black,Colors.blueGrey[900]),
    ],
    ),
    SizedBox(
    height: 30,
    ),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
    sumcon("Recovered",recov,height*0.15,width*0.45,Colors.black,Colors.blueGrey[900]),
    sumcon("Active Cases",active_cases,height*0.15,width*0.45,Colors.black,Colors.blueGrey[900]),
    ],
    ),
    ],),
    ],
    ),
    );
  }
}
Widget sumcon(num,text,height,width,tc1,tc2)  => Container(
  height: height,
  width: width,
  alignment: Alignment.center,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(
      Radius.circular(30),
    ),
    border: Border.all(
      color: Colors.blueGrey[400], //                   <--- border color
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
              fontSize: 30,
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
