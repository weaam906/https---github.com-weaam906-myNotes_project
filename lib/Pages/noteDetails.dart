import 'package:flutter/material.dart';
import 'package:add_to_list/Model/notes.dart';

class noteDetails extends StatelessWidget {
  Notes note;
  noteDetails(this.note);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${note.title} Details'),),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Text(note.title, style: Theme.of(context).textTheme.headline5,),
            SizedBox(height: 20,),
            Text(note.content, style: Theme.of(context).textTheme.bodyText2,),
          ],
        ),
      ),
    );
  }
}
