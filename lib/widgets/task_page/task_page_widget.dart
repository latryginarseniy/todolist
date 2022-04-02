import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/widgets/secondary_widgets/colors.dart';
import 'package:todolist/widgets/secondary_widgets/text_style.dart';
import 'package:todolist/widgets/task_page/task_page_widget_model.dart';

class TaskNotesPageWidget extends StatefulWidget {
  const TaskNotesPageWidget({Key? key}) : super(key: key);

  @override
  State<TaskNotesPageWidget> createState() => _TaskNotesPageWidgetState();
}

//
class _TaskNotesPageWidgetState extends State<TaskNotesPageWidget> {
  final _model = NotesPageWidgetModel();
  @override
  Widget build(BuildContext context) {
    return NotesPageWidgetModelProvider(
        model: _model, child: const _TaskNotesPageWidgetBody());
  }
}

class _TaskNotesPageWidgetBody extends StatelessWidget {
  const _TaskNotesPageWidgetBody({Key? key}) : super(key: key);

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
            'Tasks',
            style: TextStyle(
              fontFamily: 'YandexSansBold',
            ),
          ),
          actions: [
            IconButton(
                onPressed: () => showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: false,
                    context: context,
                    builder: (context) => _showBottomSheet(context, _model)),
                icon: const Icon(CupertinoIcons.add),
                iconSize: 24),
          ],
          centerTitle: true,
        ),
        body: const _UniversityListWidget());
  }

  Padding _showBottomSheet(BuildContext context, NotesPageWidgetModel? _model) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16.0), topLeft: Radius.circular(16.0)),
          color: dDarkColor,
        ),
        child: Wrap(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                ' Enter a new task:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'YandexSansBold',
                  color: dWhiteColor,
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: const TextStyle(
                  fontFamily: 'YandexSansBold',
                  color: dWhiteColor,
                  fontSize: 16,
                ),
                maxLines: 1,
                cursorColor: dGreyColor,
                onChanged: (value) => _model?.noteHeading = value,
                decoration: const InputDecoration(
                    hintText: 'Task',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(width: 0.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.0),
                    ),
                    fillColor: dLightDarkColor,
                    filled: true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () => _model?.saveNote(context),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: dLightBlueColor,
                        ),
                        height: 50,
                        alignment: Alignment.center,
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontFamily: 'YandexSansBold',
                            color: dDarkColor,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        height: 50,
                        alignment: Alignment.center,
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontFamily: 'YandexSansBold',
                            color: dGreyColor,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UniversityListWidget extends StatelessWidget {
  const _UniversityListWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _model = NotesPageWidgetModelProvider.read(context)?.model;
    final _addModel = NotesPageWidgetModelProvider.read(context)!.model;

    Widget _showSubTask(bool _openTask, int indexTask) {
      return _openTask
          ? Column(
              children: [
                ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: NotesPageWidgetModelProvider.watch(context)
                            ?.model
                            .notes[indexTask]
                            .subtask
                            ?.length ??
                        0,
                    separatorBuilder:
                        (BuildContext context, int indexSubtask) =>
                            const Divider(),
                    itemBuilder: (BuildContext context, int indexSubtask) {
                      return InkWell(
                        splashColor: dDarkColor,
                        onTap: () {},
                        child: _ListTaskWidget(
                            indexTask: indexTask, indexSubtask: indexSubtask),
                      );
                    }),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          style: const TextStyle(
                            fontFamily: 'YandexSansBold',
                            color: dDarkColor,
                            fontSize: 16,
                          ),
                          cursorColor: dGreyColor,
                          onChanged: (value) => _model?.noteDescription = value,
                          decoration: const InputDecoration(
                              hintText: '  Enter a new subtask',
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                borderSide: BorderSide(
                                    width: 0.0, color: dLightGreyColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.0, color: dLightGreyColor),
                              ),
                              fillColor: dLightGreyColor,
                              filled: true),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InkWell(
                        onTap: () {
                          _model?.saveSubNote(indexTask);
                        },
                        child: const Icon(
                          CupertinoIcons.add_circled_solid,
                          color: dDarkColor,
                          size: 32,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )
          : const SizedBox();
    }

    Icon _showSub(int index) {
      final _model = NotesPageWidgetModelProvider.read(context)?.model;
      Icon? exit = _model!.notes[index].showTask
          ? const Icon(
              CupertinoIcons.chevron_up,
              color: dWhiteColor,
              size: 18,
            )
          : const Icon(
              CupertinoIcons.chevron_down,
              color: dWhiteColor,
              size: 18,
            );
      return exit;
    }

    return ListView.builder(
      itemCount:
          NotesPageWidgetModelProvider.watch(context)?.model.notes.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        var reverseIndex =
            (NotesPageWidgetModelProvider.watch(context)?.model.notes.length ??
                    0) -
                1 -
                index;
        return SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              InkWell(
                onLongPress: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      action: SnackBarAction(
                        label: 'Delete',
                        textColor: Colors.red,
                        onPressed: () => _model?.deleteNote(reverseIndex),
                      ),
                      content: const Text(
                        '    Do you want to delete this task?',
                        style: TextStyle(
                          fontFamily: 'YandexSansRegular',
                          color: dDarkColor,
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
                      backgroundColor: dLightBlueColor,
                    ),
                  );
                },
                onTap: () => _model?.showSubTask(reverseIndex),
                child: Card(
                  color: dLightDarkColor,
                  child: Container(
                    height: 80,
                    alignment: Alignment.center,
                    child: ListTile(
                      trailing: _showSub(reverseIndex),
                      title: Text(
                        _model!.notes[reverseIndex].task,
                        textAlign: TextAlign.left,
                        style: textStyleForTask,
                      ),
                      dense: false,
                    ),
                  ),
                ),
              ),
              _showSubTask(_model.notes[reverseIndex].showTask, reverseIndex),
            ],
          ),
        );
      },
    );
  }
}

class _ListTaskWidget extends StatelessWidget {
  final int indexTask;
  final int indexSubtask;
  const _ListTaskWidget(
      {Key? key, required this.indexTask, required this.indexSubtask})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _subtaskModel = NotesPageWidgetModelProvider.read(context)?.model;

    final _model = NotesPageWidgetModelProvider.read(context)?.model;
    return ListTile(
      onLongPress: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            action: SnackBarAction(
              label: 'Delete',
              textColor: Colors.red,
              onPressed: () =>
                  _subtaskModel?.deleteSubNote(indexTask, indexSubtask),
            ),
            content: const Text(
              '    Do you want to delete this subtask?',
              style: TextStyle(
                fontFamily: 'YandexSansRegular',
                color: dDarkColor,
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
            backgroundColor: dLightBlueColor,
          ),
        );
      },
      title: Text(
        _subtaskModel!.notes[indexTask].subtask![indexSubtask],
        textAlign: TextAlign.left,
        style: textStyleForSubTask,
      ),
      dense: false,
    );
  }
}
