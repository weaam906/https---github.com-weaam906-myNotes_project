import 'package:add_to_list/Model/notes.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class dbHelper{
  // 1- Create dbHelper instance "Singletone"
  static final dbHelper _instance = dbHelper.internal();
  factory dbHelper() => _instance;
  dbHelper.internal();
  // 2-Create Database object
  static Database _db;
  // 3-Create DataBase
  Future<Database> createDatabase() async{
    // 3.1- Check if there's existed db return it
    if(_db != null) {return _db;}
    // 3.2- If there's no existed db, then
    // 3.2.1- Define the path to the database
    String path = join(await getDatabasesPath(), 'daily_notes.db');
    // 3.2.2- Open the created db given the path and version
    _db = await openDatabase(path,version:1, onCreate: (Database db, int v){
    // 3.2.3- Create the table
      db.execute('create table notes(id integer primary key autoincrement, title varchar(50), content varchar(255))');
      });
    return _db;
  }
  // 4-Create new note
  Future<int> createNote(Notes note) async{
    Database db = await createDatabase();
    return db.insert('notes', note.toMap());
  }
  // 5-List All notes
  Future<List> allNotes() async{
    Database db = await createDatabase();
    return db.query('notes');
  }
  // 6-Delete note
  Future<int> delete(int id) async{
    Database db = await createDatabase();
    return db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
  // 7-Update note
  Future<int> noteUpdate(Notes note) async{
    Database db = await createDatabase();
    return await db.update('notes', note.toMap(),where: 'id = ?', whereArgs: [note.id]);
  }
}