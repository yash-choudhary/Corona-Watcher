import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'notes.dart';

class DetailScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return DetailScreenState();
  }
}
class DetailScreenState extends State<DetailScreen> {

  List<Notes> _notes = List<Notes>();
  List<Notes> filterednotes=List();

  Future<List<Notes>> fetchNotes() async {
    var url = 'https://corona-engine.herokuapp.com/table';
    final response = await http.get(url);

    var notes = List<Notes>();

    if (response.statusCode == 200) {
      final notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(Notes.fromJson(noteJson));
      }
    }
    return notes;
  }
  bool _progressBarActive = true;
  @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _notes.addAll(value);
        _progressBarActive = false;
        filterednotes=_notes;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: Container(
          margin: EdgeInsets.symmetric(vertical: 5.0,horizontal: 5.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(50, 255, 255, 255),
            borderRadius: BorderRadius.all(Radius.circular(18.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText:"Search Country",
                        hintStyle: TextStyle(color: Colors.white60),
                        icon: Icon(Icons.search,color: Colors.white60,)
                      ),
                      onChanged: (string){
                          setState(() {
                            filterednotes=_notes.where((u)=>(u.country.toLowerCase().contains(string.toLowerCase()))).toList();
                          });
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ),
        body: _progressBarActive == true?const Center(child: const CircularProgressIndicator()):new Column(
            children: <Widget>[
              new Padding(
                padding: new EdgeInsets.only(top: 20.0),
              ),
              new Expanded(
                child: new ListView.builder(
                  itemCount: filterednotes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ExpansionTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              filterednotes[index].country,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              filterednotes[index].total_case,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.redAccent,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        children: <Widget>[
                          det_row("New Cases", filterednotes[index].new_case ),
                          det_row("New Deaths", filterednotes[index].new_death ),
                          det_row("Total Deaths", filterednotes[index].total_death ),
                          det_row("Total Recovered", filterednotes[index].total_recovered ),
                        ],
                      ),
                    );

                  },
                ),
              ),
            ]));
  }
}

Widget det_row(head,val)=>  Padding(
  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
  child:   Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          head,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        Text(
          val,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),]),
);