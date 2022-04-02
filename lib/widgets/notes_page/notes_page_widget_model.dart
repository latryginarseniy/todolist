import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/data/note.dart';

class NotesPageWidgetModel extends ChangeNotifier {
  var _notes = <Note>[];

  List<Note> get notes => _notes.toList();

  void showPopScreen(BuildContext context) {
    Navigator.of(context).pushNamed('/note/group');
  }

  NotesPageWidgetModel() {
    _updateList();
  }

  void _readNoteFromHive(Box<Note> box) {
    _notes = box.values.toList();
    notifyListeners();
  }

  void deleteNote(int indexNote) async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(NoteAdapter());
    }
    final box = await Hive.openBox<Note>('notes_box');

    await box.deleteAt(indexNote);
    _readNoteFromHive(box);
    box.listenable().addListener(() => _readNoteFromHive(box));
  }

  void _updateList() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(NoteAdapter());
    }
    final box = await Hive.openBox<Note>('notes_box');
    _readNoteFromHive(box);
    box.listenable().addListener(() => _readNoteFromHive(box));
  }
}

class NotesPageWidgetModelProvider extends InheritedNotifier {
  final NotesPageWidgetModel model;
  final Widget child;

  const NotesPageWidgetModelProvider(
      {Key? key, required this.model, required this.child})
      : super(key: key, notifier: model, child: child);

  static NotesPageWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<NotesPageWidgetModelProvider>();
  }

  static NotesPageWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<NotesPageWidgetModelProvider>()
        ?.widget;
    return widget is NotesPageWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(NotesPageWidgetModelProvider oldWidget) {
    return true;
  }
}
