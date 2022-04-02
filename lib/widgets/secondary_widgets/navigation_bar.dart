import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/widgets/secondary_widgets/colors.dart';

import 'package:todolist/widgets/notes_page/notes_page_widget.dart';
import 'package:todolist/widgets/settings_page/settings_page_widget.dart';
import 'package:todolist/widgets/task_page/task_page_widget.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottonNavigationBarWidgetState();
}

class _BottonNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    NotesPageWidget(),
    TaskNotesPageWidget(),
    SettingsPageWidget()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(
            fontFamily: 'YandexSansBold', fontSize: 12, color: dLightBlueColor),
        unselectedItemColor: dLightDarkColor,
        backgroundColor: dDarkColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.news,
              color: dLightDarkColor,
            ),
            activeIcon: Icon(CupertinoIcons.news_solid),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.doc_chart,
                color: dLightDarkColor,
              ),
              activeIcon: Icon(CupertinoIcons.doc_chart_fill),
              label: 'Tasks'),
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.square_grid_2x2,
                color: dLightDarkColor,
              ),
              activeIcon: Icon(CupertinoIcons.square_grid_2x2_fill),
              label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: dLightBlueColor,
        onTap: _onItemTapped,
      ),
    );
  }
}

//Заметки Scaffold с AppBarиконками и body

