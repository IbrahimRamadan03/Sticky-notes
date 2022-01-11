import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:petproject/Model/Note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';
import 'package:intl/intl.dart';
import 'dart:io';
class NoteDataBase{
  static final NoteDataBase instance=NoteDataBase._init();
  static Database? _database;
  //private cons
  NoteDataBase._init();
  Future <Database> get database async{
    if(_database !=null){
      return _database!;
    }
    _database=await _initDB('notes.db');
    return _database!;
  }
  
  Future<Database> _initDB(String filePath) async{
    final dbpath=await getDatabasesPath();
    final path= join(dbpath,filePath);
    return await openDatabase(path,version:1,onCreate:_onCreateDB );
  }
  Future _onCreateDB(Database db,int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
    CREATE TABLE $tableNotes (
      ${NoteFields.id} $idType,
      ${NoteFields.isImportant} $boolType,
      ${NoteFields.number} $integerType,
      ${NoteFields.title} $textType,
      ${NoteFields.description} $textType,
      ${NoteFields.time} $textType
      )
    ''');

  }
   Future <Note> create (Note note) async{
     final db= await instance.database;
     final id =await db.insert(tableNotes,note.toJson());
     return note.Copy(id:id);
   }
   Future <Note> readNote(int id) async{
     final db= await instance.database;
     final map =await db.query(tableNotes,
     columns: NoteFields.values,
     where:'${NoteFields.id} = ?',
     whereArgs: [id]
     );
     if(map.isNotEmpty){
       //we uesd the .first notation because we read only one note
       return Note.fromJson(map.first);
     }
     else{
       throw Exception('ID $id isnt found');
     }

   }
   Future <List<Note>> readAllNotes () async{
     final db = await instance.database;
     final orderby='${NoteFields.time} ASC';
     final results = await db.query(tableNotes,orderBy:orderby );
     return results.map((e) => Note.fromJson(e)).toList();
   }
   Future <int> update (Note note) async{
     final db=await instance.database;
     return db.update(tableNotes,note.toJson(),
     where: '${NoteFields.id} = ?',
     whereArgs: [note.id]
     );
   }
   Future <int> Delete (int id) async{
     final db=await instance.database;
     return db.delete(tableNotes,
     where: '${NoteFields.id} = ?',
     whereArgs: [id]
     );
   }
  Future close() async{
    final db=await instance.database;
    db.close();

  }
  
}

