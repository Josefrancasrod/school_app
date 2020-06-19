import 'package:flutter/material.dart';

import './schedule_screen.dart';
import './signatures_screen.dart';
import './homework_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, dynamic>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    _pages = [
      {'page': HomeworkScreen(), 'title': 'My Homework'},
      {'page': SignatureScreen(), 'title': 'My Signatures'},
      {'page': ScheduleScreen(), 'title': 'My Schedule'},
    ];

    super.initState();
  }

  void _selectPage(int index){
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //This can be dynammic
        title: Text(_pages[_selectedPageIndex]['title']),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.add),
        //     onPressed: () {},
        //   )
        // ],
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        
        items: [
          BottomNavigationBarItem(
            title: Text('Homework'),
            icon: Icon(Icons.assignment),
          ),
          BottomNavigationBarItem(
            title: Text('Class'),
            icon: Icon(Icons.school),
          ),
          BottomNavigationBarItem(
            title: Text('Schedule'),
            icon: Icon(Icons.calendar_today),
          ),
        ],
      ),
    );
  }
}
