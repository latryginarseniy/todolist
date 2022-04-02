import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:todolist/data/note.dart';

class NoteGroupWidgetModel {
  var noteHeading = '';
  var noteDescription = '';

  void saveNote(BuildContext context) async {
    if (noteHeading.isEmpty) return;
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(NoteAdapter());
    }
    final box = await Hive.openBox<Note>('notes_box');
    final note = Note(
        heading: noteHeading,
        description: noteDescription,
        date: DateTime.now());
    await box.add(note);
    close(context);
  }

  void close(BuildContext context) {
    Navigator.of(context).pop();
  }
}

class NoteGroupWidgetModelProvider extends InheritedWidget {
  final NoteGroupWidgetModel model;
  final Widget child;

  const NoteGroupWidgetModelProvider(
      {Key? key, required this.model, required this.child})
      : super(key: key, child: child);

  static NoteGroupWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<NoteGroupWidgetModelProvider>();
  }

  static NoteGroupWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<NoteGroupWidgetModelProvider>()
        ?.widget;
    return widget is NoteGroupWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(NoteGroupWidgetModelProvider oldWidget) {
    return true;
  }
}
