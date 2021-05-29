import 'package:flutter/material.dart';
import 'package:add_to_list/Model/notes.dart';
import 'package:add_to_list/dbHelper.dart';
import 'package:add_to_list/Pages/newNote.dart';
import 'package:add_to_list/Pages/noteDetails.dart';
import 'package:add_to_list/Pages/noteUpdate.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  dbHelper helper;
  @override
  void initState() {
    super.initState();
    helper = dbHelper();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Notes'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>newNote())),
          )
        ],
      ),
      body: FutureBuilder(
        future: helper.allNotes(),
        builder: (context, AsyncSnapshot snapshot){
          if(!snapshot.hasData){
            return CircularProgressIndicator();
          }else{
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i){
                  Notes notes = Notes.fromMap(snapshot.data[i]);
                  return Card(
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      title: Text('${notes.title}'),
                      subtitle: Text(notes.content.substring(0,200)),
                      trailing:Column(
                        children: <Widget>[
                          Expanded(
                            child: IconButton(icon: Icon(Icons.delete, color: Colors.red,),onPressed: (){
                              setState(() {helper.delete(notes.id);});
                            },),
                          ),
                          Expanded(
                            child: IconButton(icon: Icon(Icons.edit, color: Colors.green,),onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>noteUpdate(notes)));
                            },),
                          ),
                        ],
                      ),
                      onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>noteDetails(notes)));},
                    ),
                  );
                }
            );
          }
        },
      ),
    );
  }
}
