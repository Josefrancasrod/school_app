import 'package:flutter/material.dart';

import '../providers/homework.dart';

class ClassesHomeworkCard extends StatelessWidget {
  final String className;
  final Color classColor;
  final int numberOfHomework;

  ClassesHomeworkCard(this.className, this.classColor, this.numberOfHomework);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: classColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 50,
        width: 150,
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: classColor,
              radius: 10,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  numberOfHomework > 0 ? '$numberOfHomework ' : 'No ',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      color: Colors.black),
                ),
                Text(
                  numberOfHomework != 1 ? 'Tasks' : 'Task',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      color: Colors.black),
                ),
              ],
            ),
            FittedBox(
              child: Text(
                className.length < 8
                    ? className
                    : className.substring(0, 7) + '...',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
