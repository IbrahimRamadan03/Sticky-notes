// this logic was created to isolate the database from direct interaction also 
//to add some statemangenet functionality
import 'package:flutter/material.dart';
import 'package:petproject/Model/Note.dart';
import 'package:petproject/db/NoteDataBase.dart';

class noteManger with ChangeNotifier{
  
  List <Note> _notes=[];
  List<Note> get notes {
    return [..._notes];
  }

 Future <void> fetchNotes () async{
    this._notes= await NoteDataBase.instance.readAllNotes();
    notifyListeners();
  }
  Future <void> createNote(Note note) async{
  await NoteDataBase.instance.create(note);
  this._notes.add(note);
   notifyListeners();
  }
  // Future <Note> readnote(int id) async {
  //   final notefromData =await NoteDataBase.instance.readNote(id);
  //   final extractedNote=_notes.firstWhere((element) => element.id==id);
  //    notifyListeners();
  //   return extractedNote;
     
  // }
  Future <void> Update(Note note) async {
   await NoteDataBase.instance.update(note);   
    notifyListeners();
  }
  Future <void> delete(int? id) async {
    await NoteDataBase.instance.Delete(id!);
    _notes.removeWhere((element) => element.id==id);
    notifyListeners();
  }
  
}