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
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Material(
        child: _progressBarActive == true?const Center(child: const CircularProgressIndicator()):new Column(
            children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(top: 20.0),
          ),
          new Expanded(
            child: new ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ExpansionTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          _notes[index].country,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _notes[index].total_case,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    children: <Widget>[
                      det_row("New Cases", _notes[index].new_case ),
                      det_row("New Deaths", _notes[index].new_death ),
                      det_row("Total Deaths", _notes[index].total_death ),
                      det_row("Total Recovered", _notes[index].total_recovered ),
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