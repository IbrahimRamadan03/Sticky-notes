import 'package:flutter/material.dart';
import 'package:petproject/Model/Note.dart';
import 'package:intl/intl.dart';

final _lightColors = [
  Colors.amber.shade300,
  Colors.lightGreen.shade300,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100
];

class NoteCard extends StatelessWidget {
  final int indexOfColors;
  final Note note;
  NoteCard(this.note, this.indexOfColors);

  @override
  Widget build(BuildContext context) {
    final color = _lightColors[indexOfColors % _lightColors.length];
    final minHeight = getMinHeight(indexOfColors);
    final time = DateFormat.yMMMd().format(note.creationTime);
    return Card(
      color: color,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: TextStyle(color: Colors.grey.shade700),
            ),
            SizedBox(height: 4),
            Text(
              note.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// To return different height for different widgets
double getMinHeight(int index) {
  switch (index % 4) {
    case 0:
      return 100;
    case 1:
      return 150;
    case 2:
      return 150;
    case 3:
      return 100;
    default:
      return 100;
  }
}
