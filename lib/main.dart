import 'package:flutter/material.dart';
import 'package:petproject/logic/NoteMangement.dart';
import 'package:petproject/Pages/NoteDetailPage.dart';
import 'package:petproject/Pages/NotesPage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(ctx)=>noteManger(),
      child: MaterialApp(
        title: 'Flutter Demo',
          themeMode: ThemeMode.dark,
        theme: ThemeData(
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.blueGrey.shade900,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
        home:NotesPage(),
        routes: {
          NotesPage.routeName:(context)=>NotesPage()
        }
        
      ),
    );
  
  }

}


