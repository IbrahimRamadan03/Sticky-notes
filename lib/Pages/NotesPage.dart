import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:petproject/Model/Note.dart';
import 'package:petproject/logic/NoteMangement.dart';
import 'package:petproject/widgets/NoteCard.dart';
import 'package:petproject/Pages/Add_or_edit_NotePage.dart';
import 'package:petproject/Pages/NoteDetailPage.dart';
import 'package:petproject/db/NoteDataBase.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  static const routeName='NotesPage';
//  List<Note> notesList(BuildContext context) {

//   }

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  bool _isinit=true;
  bool _isloading=false;
  @override
  void didChangeDependencies() {
    if(_isinit){
      setState(() {
        _isloading=true;
      });
      Provider.of<noteManger>(context,listen:false).fetchNotes().then((_) {
        setState(() {
          _isloading=false;
        });
      } );
    }
    _isinit=false;

    super.didChangeDependencies();
  }
  @override
  void dispose() {
    NoteDataBase.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notedate = Provider.of<noteManger>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notes',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child:_isloading?CircularProgressIndicator(): notedate.notes.isEmpty
            ? Text(
                'No Notes Added',
                style: TextStyle(color: Colors.white),
              )
            : StaggeredGridView.countBuilder(
                padding: EdgeInsets.all(8),
                crossAxisCount: 4,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                itemCount: notedate.notes.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: ()  {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              NoteDetailsPage(notedate.notes[index])));
                    },
                    child: NoteCard(notedate.notes[index], index),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: ()  {
         Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddNotePage()),
          );
        },
      ),
    );
  }
}
