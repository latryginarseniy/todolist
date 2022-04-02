import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/widgets/secondary_widgets/colors.dart';
import 'package:todolist/widgets/edit_note_group/edit_note_group_widget_model.dart';

class EditNoteGroupWidget extends StatefulWidget {
  final int indexNote;
  const EditNoteGroupWidget({Key? key, required this.indexNote})
      : super(key: key);

  @override
  State<EditNoteGroupWidget> createState() => _EditNoteGroupWidgetState();
}

class _EditNoteGroupWidgetState extends State<EditNoteGroupWidget> {
  @override
  Widget build(BuildContext context) {
    final _model = EditNotesPageWidgetModel(widget.indexNote);
    return EditNotesPageWidgetModelProvider(
        model: _model, child: const _NoteGroupWidgetBody());
  }
}

class _NoteGroupWidgetBody extends StatelessWidget {
  const _NoteGroupWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = EditNotesPageWidgetModelProvider.read(context)?.model;

    return Scaffold(
        backgroundColor: dDarkColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: dDarkColor,
          leading: IconButton(
              onPressed: () => _model?.close(context),
              icon: const Icon(CupertinoIcons.chevron_back),
              iconSize: 22),
          title: const Text(
            'Edit note',
            style: TextStyle(
              fontFamily: 'YandexSansBold',
            ),
          ),
          actions: [
            IconButton(
                onPressed: () => _model?.saveNote(context),
                icon: const Icon(CupertinoIcons.checkmark_alt),
                iconSize: 24),
          ],
          centerTitle: true,
        ),
        body: const _NoteGroupWidgetForm());
  }
}

class _NoteGroupWidgetForm extends StatelessWidget {
  const _NoteGroupWidgetForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _index =
        EditNotesPageWidgetModelProvider.read(context)!.model.indexEditNote;
    final _note =
        EditNotesPageWidgetModelProvider.read(context)?.model.notes[_index];
    final _model = EditNotesPageWidgetModelProvider.read(context)?.model;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              initialValue: _note?.heading,
              style: const TextStyle(
                fontFamily: 'YandexSansBold',
                color: dWhiteColor,
                fontSize: 16,
              ),
              maxLines: 1,
              cursorColor: dGreyColor,
              onChanged: (value) => _model?.newNoteHeading = value,
              decoration: const InputDecoration(
                  label: Text(
                    '  Heading',
                    style: TextStyle(
                      fontFamily: 'YandexSansBold',
                      color: dGreyColor,
                      fontSize: 16,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.0),
                  ),
                  fillColor: dLightDarkColor,
                  filled: true),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              initialValue: _note?.description,
              maxLines: 40,
              cursorColor: dGreyColor,
              style: const TextStyle(
                fontFamily: 'YandexSansMedium',
                color: dWhiteColor,
                fontSize: 16,
              ),
              onChanged: (value) => _model?.newNoteDescription = value,
              decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  label: Text(
                    '  Description',
                    style: TextStyle(
                      fontFamily: 'YandexSansMedium',
                      color: dGreyColor,
                      fontSize: 16,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.0),
                  ),
                  fillColor: dLightDarkColor,
                  filled: true),
            )
          ],
        ),
      ),
    );
  }
}
