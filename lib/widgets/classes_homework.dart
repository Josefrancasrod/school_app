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
            Text(
              className,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 5,
            ),
            Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        numberOfHomework > 0 ? '$numberOfHomework': 'No',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        numberOfHomework != 1 ?  'Tasks': 'Task',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  )
                
          ],
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              classColor.withOpacity(0.7),
              classColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
