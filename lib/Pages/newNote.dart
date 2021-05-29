import 'package:flutter/material.dart';
import 'package:add_to_list/Model/notes.dart';
import 'package:add_to_list/dbHelper.dart';

class newNote extends StatefulWidget {
  @override
  _newNoteState createState() => _newNoteState();
}

class _newNoteState extends State<newNote> {
  String title, content;
  dbHelper helper;

  @override
  void initState() {
    super.initState();
    helper = dbHelper();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Note'),),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(hintText: 'Enter title'),
                onChanged: (value){setState(() {title = value;});},
              ),

              SizedBox(height: 15,),

              TextFormField(
                maxLines: 10,
                decoration: InputDecoration(hintText: 'Enter Content'),
                onChanged: (value){setState(() {content = value;});},
              ),

              SizedBox(height: 15,),

              RaisedButton(
                child: Text('Save'),
                onPressed: () async{
                  Notes note = Notes({'title':title,'content':content});
                  int id = await helper.createNote(note);
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

