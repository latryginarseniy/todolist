import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/widgets/secondary_widgets/colors.dart';
import 'package:todolist/widgets/note_group/note_group_widget_model.dart';

class NoteGroupWidget extends StatefulWidget {
  const NoteGroupWidget({Key? key}) : super(key: key);

  @override
  State<NoteGroupWidget> createState() => _NoteGroupWidgetState();
}

class _NoteGroupWidgetState extends State<NoteGroupWidget> {
  final _model = NoteGroupWidgetModel();

  @override
  Widget build(BuildContext context) {
    return NoteGroupWidgetModelProvider(
        model: _model, child: const _NoteGroupWidgetBody());
  }
}

class _NoteGroupWidgetBody extends StatelessWidget {
  const _NoteGroupWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = NoteGroupWidgetModelProvider.read(context)?.model;

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
            'New note',
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
    final _model = NoteGroupWidgetModelProvider.read(context)?.model;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              style: const TextStyle(
                fontFamily: 'YandexSansBold',
                color: dWhiteColor,
                fontSize: 16,
              ),
              maxLines: 1,
              cursorColor: dGreyColor,
              onChanged: (value) => _model?.noteHeading = value,
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
            TextField(
              minLines: 20,
              maxLines: 40,
              cursorColor: dGreyColor,
              style: const TextStyle(
                fontFamily: 'YandexSansMedium',
                color: dWhiteColor,
                fontSize: 16,
              ),
              onChanged: (value) => _model?.noteDescription = value,
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
