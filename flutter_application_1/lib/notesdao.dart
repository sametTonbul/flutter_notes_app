import 'package:flutter_application_1/databaseaccess.dart';
import 'package:flutter_application_1/noteclass.dart';

class NotesDAO {
  Future<List<Notes>> allNotesDAO() async {
    var databaseDAO = await DatabaseHelper.accessDatabase();

    List<Map<String, dynamic>> mapNotesDAO =
        await databaseDAO.rawQuery('SELECT * FROM notes');

    return List.generate(mapNotesDAO.length, (index) {
      var rawNotesDAO = mapNotesDAO[index];
      return Notes(rawNotesDAO['note_id'], rawNotesDAO['lesson_name'],
          rawNotesDAO['note_1'], rawNotesDAO['note_2']);
    });
  }

  Future<void> addNote(String lesson_name, int note_1, int note_2) async {
    var databaseAddNote = await DatabaseHelper.accessDatabase();
    var infoAddNote = Map<String, dynamic>();
    infoAddNote['lesson_name'] = lesson_name;
    infoAddNote['note_1'] = note_1;
    infoAddNote['note_2'] = note_2;
    await databaseAddNote.insert('notes', infoAddNote);
  }

  Future<void> deleteNote(int note_id) async {
    var databaseDeleteNote = await DatabaseHelper.accessDatabase();
    await databaseDeleteNote
        .delete('notes', where: 'note_id=?', whereArgs: [note_id]);
  }

  Future<void> editNote(
      int note_id, String lesson_name, int note_1, int note_2) async {
    var databaseEditNote = await DatabaseHelper.accessDatabase();
    var infoEditNote = Map<String, dynamic>();
    infoEditNote['lesson_name'] = lesson_name;
    infoEditNote['note_1'] = note_1;
    infoEditNote['note_2'] = note_2;
    await databaseEditNote.update('notes', infoEditNote,
        where: 'note_id=?', whereArgs: [note_id]);
  }
}
