import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/notesdao.dart';

class NotesSave extends StatefulWidget {
  const NotesSave({super.key});

  @override
  State<NotesSave> createState() => _NotesSaveState();
}

class _NotesSaveState extends State<NotesSave> {
  var tfLessonName = TextEditingController();
  var tfNote1 = TextEditingController();
  var tfNote2 = TextEditingController();

  Future<void> saveNote(String lesson_name, int note_1, int note_2) async {
    await NotesDAO().addNote(lesson_name, note_1, note_2);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NOTES SAVE PAGE'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextField(
                controller: tfLessonName,
                decoration: InputDecoration(hintText: 'Lesson Name'),
              ),
              TextField(
                controller: tfNote1,
                decoration: InputDecoration(hintText: 'Note 1'),
              ),
              TextField(
                controller: tfNote2,
                decoration: InputDecoration(hintText: 'Note 2'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saveNote(tfLessonName.text, int.parse(tfNote1.text),
              int.parse(tfNote2.text));
        },
        tooltip: 'Save Note',
        child: const Icon(Icons.save),
      ),
    );
    ;
  }
}
