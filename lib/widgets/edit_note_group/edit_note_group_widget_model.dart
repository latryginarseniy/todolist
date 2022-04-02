import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/data/note.dart';

class EditNotesPageWidgetModel extends ChangeNotifier {
  var oldNoteHeading = '';
  var oldNoteDescription = '';
  var newNoteHeading = '';
  var newNoteDescription = '';
  dynamic indexEditNote;
  var _notes = <Note>[];
  List<Note> get notes => _notes.toList();

  EditNotesPageWidgetModel(this.indexEditNote) {
    _getList();
  }
  void _getList() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(NoteAdapter());
    }
    final box = Hive.box<Note>('notes_box');
    _notes = box.values.toList();
    oldNoteHeading = _notes[indexEditNote].heading;
    oldNoteDescription = _notes[indexEditNote].description;
  }

  void saveNote(BuildContext context) async {
    if (newNoteHeading.isEmpty) {
      newNoteHeading = oldNoteHeading;
    }
    if (newNoteDescription.isEmpty) {
      newNoteDescription = oldNoteDescription;
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(NoteAdapter());
    }
    final box = await Hive.openBox<Note>('notes_box');
    final note = Note(
        heading: newNoteHeading,
        description: newNoteDescription,
        date: DateTime.now());
    await box.deleteAt(indexEditNote);
    _notes = box.values.toList();
    await box.add(note);
    close(context);
  }

  void close(BuildContext context) {
    Navigator.of(context).pop();
  }
}

class EditNotesPageWidgetModelProvider extends InheritedNotifier {
  final EditNotesPageWidgetModel model;
  final Widget child;

  const EditNotesPageWidgetModelProvider(
      {Key? key, required this.model, required this.child})
      : super(key: key, notifier: model, child: child);

  static EditNotesPageWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<EditNotesPageWidgetModelProvider>();
  }

  static EditNotesPageWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<
            EditNotesPageWidgetModelProvider>()
        ?.widget;
    return widget is EditNotesPageWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(EditNotesPageWidgetModelProvider oldWidget) {
    return true;
  }
}
