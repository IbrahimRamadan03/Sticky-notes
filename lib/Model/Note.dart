final String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    /// Add all fields
    id, isImportant, number, title, description, time
  ];

  static final String id = '_id';
  static final String isImportant = 'isImportant';
  static final String number = 'number';
  static final String title = 'title';
  static final String description = 'description';
  static final String time = 'time';
}

class Note {
late final int? id;
  final String title;
  final int number;
  final String description;
  final bool isImportant;
  final DateTime creationTime;
   Note(
      {this.id,
      required this.title,
      required this.number,
      required this.description,
      required this.isImportant,
      required this.creationTime});
  Note Copy({
    //the new values comming freom the db
    int? id,
    String? title,
    int? number,
    String? description,
    bool? isImportant,
    DateTime? creationTime,
  }) =>
      Note(
          id: id ?? this.id,
          title: title ?? this.title,
          number: number ?? this.number,
          description: description ?? this.description,
          isImportant: isImportant ?? this.isImportant,
          creationTime: creationTime ?? this.creationTime);

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.isImportant: isImportant ? 1 : 0,
        NoteFields.number: number,
        NoteFields.description: description,
        NoteFields.time: creationTime.toIso8601String(),
      };
      static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        isImportant: json[NoteFields.isImportant] == 1,
        number: json[NoteFields.number] as int,
        title: json[NoteFields.title] as String,
        description: json[NoteFields.description] as String,
        creationTime: DateTime.parse(json[NoteFields.time] as String),
      );
}
