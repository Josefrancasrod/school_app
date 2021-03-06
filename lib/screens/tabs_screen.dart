import 'package:flutter/material.dart';

import './new_homework_screen.dart';
import './profile_screen.dart';
import './schedule_screen.dart';
import './classes_screen.dart';
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
      {'page': ClassesScreen(), 'title': 'My Classes'},
      {'page': ScheduleScreen(), 'title': 'My Schedule'},
      {'page': ProfileScreen(), 'title': 'My Profile'},
    ];

    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Color _selectedOption(int index) {
    return index == _selectedPageIndex ? Theme.of(context).accentColor : Colors.grey;
  }

  Widget _bottomButtonsCreation(
      Color color, Function function, IconData icon, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: IconButton(
        onPressed: function,
        icon: Icon(
          icon,
          color: color,
        ),
      ),
    );
  }

  Future<void> _goToNewHomeworkScreen() async {
    await Navigator.of(context).pushNamed(NewHomeworkScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: Text(
      //     _pages[_selectedPageIndex]['title'],
      //     style: TextStyle(
      //       fontWeight: FontWeight.w300,
      //       color: Colors.black,
      //       fontFamily: 'Montserrat',
      //     ),
      //   ),
      //   actions: <Widget>[
      //     IconButton(
      //       onPressed: () {},
      //       icon: Icon(
      //         Icons.add,
      //         color: Colors.black,
      //       ),
      //     ),
      //   ],
      // ),
      body: _pages[_selectedPageIndex]['page'],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _goToNewHomeworkScreen();
          //Add a new[Homework, Class, ]
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).accentColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _bottomButtonsCreation(
                _selectedOption(0),
                () => _selectPage(0),
                Icons.assignment,
                _selectedPageIndex,
              ),
              _bottomButtonsCreation(
                _selectedOption(2),
                () => _selectPage(2),
                Icons.calendar_today,
                _selectedPageIndex,
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
