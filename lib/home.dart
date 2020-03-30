import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class HomeScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen>  {
  String cases;
  String deaths;
  String recov;
  String active_cases;
  String new_cases;
  String new_deaths;
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
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text("Overview",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
              fontSize: 30,
            ),
          ),
        ),
        body: Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            color: Colors.white,
            child:ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                SizedBox(
                  height: height*0.10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    sumcon("Total Cases",cases,height*0.15,width*0.47,Colors.redAccent,Colors.black45),
                    sumcon("New Cases",new_cases,height*0.15,width*0.47,Colors.black,Colors.black45),
                  ],
                ),

                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    sumcon("Total Deaths",deaths,height*0.15,width*0.47,Colors.black,Colors.black45),
                    sumcon("New Deaths",new_deaths,height*0.15,width*0.47,Colors.black,Colors.black45),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    sumcon("Total Recovered",recov,height*0.15,width*0.47,Colors.black,Colors.black45),
                    sumcon("Active Cases",active_cases,height*0.15,width*0.47,Colors.black,Colors.black45),
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

              ],)));

  }}


  Widget sumcon(num,text,height,width,tc1,tc2)  => Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(35),
        ),
        border: Border.all(
          color: Colors.redAccent, //                   <--- border color
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

