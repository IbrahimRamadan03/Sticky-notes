import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petproject/Model/Note.dart';
import 'package:petproject/logic/NoteMangement.dart';
import 'package:petproject/Pages/Add_or_edit_NotePage.dart';
import 'package:petproject/Pages/NotesPage.dart';
import 'package:provider/provider.dart';

class NoteDetailsPage extends StatefulWidget {
  static const routeName = 'NoteDetalisPage';
  final Note note;
  NoteDetailsPage(this.note);

  @override
  _NoteDetailsPageState createState() => _NoteDetailsPageState();
}

class _NoteDetailsPageState extends State<NoteDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [deleteButton(),editButton()],
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 8),
          children: [
            Text(
              widget.note.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              DateFormat.yMMMd().format(widget.note.creationTime),
              style: TextStyle(color: Colors.white38),
            ),
            SizedBox(height: 8),
            Text(
              widget.note.description,
              style: TextStyle(color: Colors.white70, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }

  Widget deleteButton() => IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          if (widget.note.id == null) {
            print('Errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
          } else {
            await Provider.of<noteManger>(context, listen: false)
                .delete(widget.note.id);

            Navigator.of(context).pushReplacementNamed(NotesPage.routeName);
          }
        },
      );

  Widget editButton() => IconButton(
      icon: Icon(Icons.edit_outlined),
      onPressed: () async {
        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddNotePage(note: widget.note),
        ));
      });
}
