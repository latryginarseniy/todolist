import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/widgets/secondary_widgets/colors.dart';
import 'package:todolist/widgets/secondary_widgets/text_style.dart';
import 'package:todolist/widgets/notes_page/notes_page_widget_model.dart';
import 'package:todolist/widgets/edit_note_group/edit_note_group_widget.dart';

class NotesPageWidget extends StatefulWidget {
  const NotesPageWidget({Key? key}) : super(key: key);

  @override
  State<NotesPageWidget> createState() => _NotesPageWidgetState();
}

class _NotesPageWidgetState extends State<NotesPageWidget> {
  final _model = NotesPageWidgetModel();
  @override
  Widget build(BuildContext context) {
    return NotesPageWidgetModelProvider(
        model: _model, child: const _NotesPageWidgetBody());
  }
}

class _NotesPageWidgetBody extends StatelessWidget {
  const _NotesPageWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = NotesPageWidgetModelProvider.read(context)?.model;
    return Scaffold(
        backgroundColor: dWhiteColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: dDarkColor,
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.person_alt_circle),
              iconSize: 28),
          title: const Text(
            'Notes',
            style: TextStyle(
              fontFamily: 'YandexSansBold',
            ),
          ),
          actions: [
            IconButton(
                onPressed: () => _model?.showPopScreen(context),
                icon: const Icon(CupertinoIcons.add),
                iconSize: 24),
          ],
          centerTitle: true,
        ),
        body: const ToDoListViewWidget());
  }
}

class ToDoListViewWidget extends StatelessWidget {
  const ToDoListViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notesCount =
        NotesPageWidgetModelProvider.watch(context)?.model.notes.length ?? 0;
    final _model = NotesPageWidgetModelProvider.read(context)?.model;
    return ListView.builder(
      itemCount: notesCount,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            splashColor: dDarkColor,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditNoteGroupWidget(indexNote: index)));
            },
            onLongPress: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  action: SnackBarAction(
                    label: 'Delete',
                    textColor: Colors.red,
                    onPressed: () => _model!.deleteNote(index),
                  ),
                  content: const Text(
                    '    Do you want to delete this note?',
                    style: TextStyle(
                      fontFamily: 'YandexSansRegular',
                      color: dWhiteColor,
                      fontSize: 14,
                    ),
                  ),
                  duration: const Duration(milliseconds: 3000),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  backgroundColor: dDarkColor,
                ),
              );
            },
            child: _CartNoteWidget(indexNote: index));
      },
    );
  }
}

class _CartNoteWidget extends StatelessWidget {
  final int indexNote;
  const _CartNoteWidget({Key? key, required this.indexNote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _note =
        NotesPageWidgetModelProvider.read(context)!.model.notes[indexNote];
    return Card(
      color: dLightDarkColor,
      child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 16.0, bottom: 4.0),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _note.heading,
                  textAlign: TextAlign.left,
                  style: textStyleForHeading,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(_note.description,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    style: textStyleForDescription,
                    overflow: TextOverflow.ellipsis),
              ),
              Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    _note.date.hour.toString() +
                        ':' +
                        _note.date.minute.toString() +
                        '\t' +
                        _note.date.day.toString() +
                        '.' +
                        _note.date.month.toString() +
                        '.' +
                        _note.date.year.toString(),
                    style: textStyleForDate,
                  ))
            ],
          )),
    );
  }
}
