import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/noteclass.dart';
import 'package:flutter_application_1/notesdao.dart';

class NotesDetail extends StatefulWidget {
  Notes note;

  NotesDetail(this.note);

  @override
  State<NotesDetail> createState() => _NotesDetailState();
}

class _NotesDetailState extends State<NotesDetail> {
  var tfLessonName = TextEditingController();
  var tfNote1 = TextEditingController();
  var tfNote2 = TextEditingController();

  Future<void> delete(int note_id) async {
    await NotesDAO().deleteNote(note_id);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  Future<void> edit(
      int note_id, String lesson_name, int note_1, int note_2) async {
    await NotesDAO().editNote(note_id, lesson_name, note_1, note_2);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  @override
  void initState() {
    super.initState();
    var note = widget.note;
    tfLessonName.text = note.lesson_name;
    tfNote1.text = note.note_1.toString();
    tfNote2.text = note.note_2.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                delete(widget.note.note_id);
              },
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.white, fontSize: 16),
              )),
          TextButton(
              onPressed: () {
                edit(widget.note.note_id, tfLessonName.text,
                    int.parse(tfNote1.text), int.parse(tfNote2.text));
              },
              child: Text('Edit',
                  style: TextStyle(color: Colors.white, fontSize: 16))),
        ],
        title: Text('NOTES DETAIL'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 50, left: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextField(
                controller: tfLessonName,
                decoration: InputDecoration(hintText: "Lesson Name"),
              ),
              TextField(
                controller: tfNote1,
                decoration: InputDecoration(hintText: "Note 1"),
              ),
              TextField(
                controller: tfNote2,
                decoration: InputDecoration(hintText: "Note 2"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
