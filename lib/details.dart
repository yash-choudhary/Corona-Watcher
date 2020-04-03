import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _notes.addAll(value);
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Material(
        child: new Column(
            children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(top: 20.0),
          ),
          new Expanded(
            child: new ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                           Padding(
                             padding: EdgeInsets.only(top: 32.0,bottom: 22.0,left: 8.0,right: 0.0),
                           ),
                        Text(
                          "COUNTRY:",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          _notes[index].country,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "TOTAL CASES:",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          _notes[index].total_case,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ExpansionTile(
                          trailing: Icon(Icons.flag),
                          title: Text("Details",style: TextStyle(fontSize:20,color: Colors.black ),),
                          children: <Widget>[
                            Column(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: <Widget>[
                                 Text(
                                   "TOTAL DEATH:",
                                   style: TextStyle(
                                     fontSize: 15,
                                     fontWeight: FontWeight.bold,
                                     color: Colors.red,
                                   ),
                                 ),
                                 Text(
                                   _notes[index].total_death,
                                   style: TextStyle(
                                     fontSize: 15,
                                     color: Colors.black87,
                                     fontWeight: FontWeight.bold,
                                   ),
                                 ),
                                 Text(
                                   "TOTAL RECOVERED:",
                                   style: TextStyle(
                                     fontSize: 15,
                                     fontWeight: FontWeight.bold,
                                     color: Colors.red,
                                   ),
                                 ),
                                 Text(
                                   _notes[index].total_recovered,
                                   style: TextStyle(
                                     fontSize: 15,
                                     color: Colors.black87,
                                     fontWeight: FontWeight.bold,
                                   ),
                                 ),
                               ],
                            )
                          ],
                        )
                      ],
                  ),
                );

              },
            ),
          ),
        ]));
  }
}