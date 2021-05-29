import 'package:flutter/material.dart';
import 'package:add_to_list/Model/notes.dart';
import 'package:add_to_list/dbHelper.dart';

class noteUpdate extends StatefulWidget {
  Notes note;
  noteUpdate(this.note);

  @override
  _noteUpdateState createState() => _noteUpdateState();
}

class _noteUpdateState extends State<noteUpdate> {
  TextEditingController teTitle = TextEditingController();
  TextEditingController teContent = TextEditingController();
  dbHelper helper;

  @override
  void initState() {
    super.initState();
    helper = dbHelper();
    teTitle.text = widget.note.title;
    teContent.text = widget.note.content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (title: Text('Note Update'),),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: <Widget>[
            TextField(controller: teTitle),
            TextField(maxLines: null,controller: teContent),
            RaisedButton(child: Text('Save'),onPressed: (){
              var updatedNote = Notes({
                'id' : widget.note.id,
                'title' : teTitle.text,
                'content' : teContent.text,
              });
              helper.noteUpdate(updatedNote);
              Navigator.of(context).pop();
            },),
          ],
        ),
      ),
    );
  }
}
