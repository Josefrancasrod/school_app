import 'package:flutter/material.dart';

import '../screens/about-screen.dart';
import '../screens/classes_screen.dart';
import '../screens/new_classes_screen.dart';
import '../screens/new_homework_screen.dart';

class BottomSheetMenu extends StatelessWidget {
  static void modal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (ctx) => Wrap(
        children: <Widget>[
          Container(
            // height: 275,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: BottomSheetMenu(),
          ),
        ],
      ),
    );
  }

  Widget _optionButton(IconData icon, String text, Function function) {
    return InkWell(
      onTap: function,
      child: Container(
        width: double.infinity,
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(icon),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 5,
            width: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(30),
                  right: Radius.circular(30),
                ),
                color: Theme.of(context).primaryColor),
          ),
          Container(
            width: double.infinity,
            child: ListTile(
              // onTap: () {},
              contentPadding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                child: Icon(
                  Icons.school,
                  color: Colors.white,
                ),
              ),
              title: Text(
                'School App', //CHANGE THE NAME
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Theme.of(context).accentColor,
                ),
              ),
              subtitle: Text(
                'Developed by @josefrancasrod', //CHANGE THE NAME
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Divider(),
              _optionButton(
                Icons.school,
                'My classes',
                () {
                  Navigator.of(context).pushNamed(ClassesScreen.routeName);
                },
              ),
              Divider(),
              _optionButton(
                Icons.school,
                'Add a new class',
                () {
                  Navigator.of(context).pushNamed(NewClassesScreen.routeName);
                },
              ),
              _optionButton(
                Icons.assignment,
                'New assigment',
                () {
                  Navigator.of(context).pushNamed(NewHomeworkScreen.routeName);
                },
              ),
              Divider(),
              _optionButton(
                Icons.info,
                'About',
                () {
                  Navigator.of(context).pushNamed(AboutScreen.routeName);
                }, //Navigate to ABOUT SCREEN
              ),
            ],
          )
        ],
      ),
    );
  }
}
