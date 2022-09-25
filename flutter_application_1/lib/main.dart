import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/noteclass.dart';
import 'package:flutter_application_1/notesdao.dart';
import 'package:flutter_application_1/notesdetail.dart';
import 'package:flutter_application_1/notessave.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double total = 0;

  Future<List<Notes>> showAllNotes() async {
    var notesList = await NotesDAO().allNotesDAO();
    return notesList;
  }

  Future<bool> turnOffApp() async {
    await exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            turnOffApp();
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('NOTES APPLICATION',
                style: TextStyle(color: Colors.white, fontSize: 16)),
            FutureBuilder(
                future: showAllNotes(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var notesList = snapshot.data;
                    double average = 0.0;
                    if (notesList != null) {
                      if (notesList.isEmpty) {
                        total;
                      } else {
                        for (var i in notesList) {
                          total = total + (i.note_1 + i.note_2) / 2;
                        }
                        average = total / notesList.length;
                      }
                      return Text('Average : ${average.toDouble()}');
                    }
                  } else {
                    return Text('Average : 0');
                  }
                  return SizedBox.shrink();
                }),
          ],
        ),
      ),
      body: WillPopScope(
        onWillPop: turnOffApp,
        child: FutureBuilder(
            future: showAllNotes(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var notesList = snapshot.data;
                return ListView.builder(
                    itemCount: notesList!.length,
                    itemBuilder: ((context, index) {
                      var note = notesList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotesDetail(note),
                              ));
                        },
                        child: Card(
                            child: SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(note.lesson_name),
                              Text(note.note_1.toString()),
                              Text(note.note_2.toString()),
                            ],
                          ),
                        )),
                      );
                    }));
              } else {
                return SizedBox.shrink();
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotesSave(),
                ));
          },
          tooltip: 'Add Note',
          child: const Icon(Icons.add)),
    );
  }
}
