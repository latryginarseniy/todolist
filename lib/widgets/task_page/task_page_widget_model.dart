import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/data/task.dart';

class NotesPageWidgetModel extends ChangeNotifier {
  var _notes = <Task>[];

  List<Task> get notes => _notes.toList();
  var noteHeading = '';
  var noteDescription = '';
  var subtaskExample = <String>[];

  NotesPageWidgetModel() {
    _updateList();
  }

  void _readNoteFromHive(Box<Task> box) {
    _notes = box.values.toList();
    notifyListeners();
  }

  void deleteNote(int indexNote) async {
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(TaskAdapter());
    }
    final box = await Hive.openBox<Task>('tasks');

    await box.deleteAt(indexNote);
    _readNoteFromHive(box);
    box.listenable().addListener(() => _readNoteFromHive(box));
  }

  void deleteSubNote(int indexNote, int indexSubNote) async {
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(TaskAdapter());
    }
    final box = await Hive.openBox<Task>('tasks');

    var oldNote = box.getAt(indexNote);
    //await box.deleteAt(indexNote);
    //Task? newNote = oldNote;
    oldNote!.subtask?.removeAt(indexSubNote);

    //await box.add(newNote);
    box.putAt(indexNote, oldNote);
    _readNoteFromHive(box);
    box.listenable().addListener(() => _readNoteFromHive(box));
  }

  void _updateList() async {
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(TaskAdapter());
    }
    final box = await Hive.openBox<Task>('tasks');
    _readNoteFromHive(box);
    box.listenable().addListener(() => _readNoteFromHive(box));
  }

  void saveNote(BuildContext context) async {
    if (noteHeading.isEmpty) return;
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(TaskAdapter());
    }
    final box = await Hive.openBox<Task>('tasks');
    final note = Task(task: noteHeading, subtask: <String>[], showTask: true);
    await box.add(note);
    close(context);
  }

  void saveSubNote(int index) async {
    if (noteDescription.isEmpty) return;
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(TaskAdapter());
    }
    final box = await Hive.openBox<Task>('tasks');
    var oldNote = box.getAt(index);
    // await box.deleteAt(index);
    // Task? newNote = oldNote;
    oldNote!.subtask?.add(noteDescription);
    await box.putAt(index, oldNote);
    _readNoteFromHive(box);
    box.listenable().addListener(() => _readNoteFromHive(box));
  }

  void close(BuildContext context) {
    Navigator.of(context).pop();
  }

  void showSubTask(int index) async {
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(TaskAdapter());
    }
    final box = await Hive.openBox<Task>('tasks');
    var oldNote = box.getAt(index);
    if (oldNote!.showTask == false) {
      oldNote.showTask = true;
    } else {
      oldNote.showTask = false;
    }
    box.putAt(index, oldNote);
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
