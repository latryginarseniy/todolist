import 'package:flutter/material.dart';
import 'package:todolist/widgets/note_group/note_group_widget.dart';
import 'package:todolist/widgets/secondary_widgets/colors.dart';
import 'package:todolist/widgets/secondary_widgets/navigation_bar.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Заметки',
      routes: {'/note/group': (context) => const NoteGroupWidget()},
      theme: ThemeData(
        primaryColor: dDarkColor,
      ),
      debugShowCheckedModeBanner: false,
      home: const BottomNavigationBarWidget(),
    );
  }
}
