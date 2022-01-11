import 'package:flutter/material.dart';
import 'package:petproject/Model/Note.dart';
import 'package:petproject/logic/NoteMangement.dart';
import 'package:petproject/widgets/NoteFormWidget.dart';
import 'package:petproject/Pages/NotesPage.dart';
import 'package:provider/provider.dart';
class AddNotePage extends StatefulWidget {
  final Note? note;
  
  AddNotePage({this.note});
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  @override
  void initState() {
     isImportant = widget.note?.isImportant ?? false;
    number = widget.note?.number ?? 0;
    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';

    super.initState();
  }
  final _formKey = GlobalKey<FormState>();
  late bool isImportant;
  late int number;
 late  String title;
  late String description;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
      body:Form(
        key: _formKey,
        child:NoteFormWidget(
          isImportant: isImportant,
            number: number,
            title: title,
            description: description,
            onChangedImportant: (isImportant) =>
                setState(() => this.isImportant = isImportant),
            onChangedNumber: (number) => setState(() => this.number = number),
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (description) =>
                setState(() => this.description = description),
          ),
        ),
      
    );
  }

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateNote,
        child: Text('Save'),
      ),
    );
  }
  void addOrUpdateNote() async {
    //validate first
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pushReplacementNamed(NotesPage.routeName);
    }
  }
  Future updateNote() async {
  final updatedNote=widget.note!.Copy(
     isImportant: isImportant,
      number: number,
      title: title,
      description: description,
  );
 

    Provider.of<noteManger>(context,listen:false).Update(updatedNote);
  }

   Future addNote() async {
    final note = Note(
      title: title,
      isImportant: true,
      number: number,
      description: description,
      creationTime: DateTime.now(),
    );

   await Provider.of<noteManger>(context,listen:false).createNote(note);
  //  await Provider.of<noteManger>(context,listen:false).fetchNotes();
   
 
  }
  }
    
  
  
  
  