import 'package:flutter/material.dart';

import '../providers/homework.dart' as homework;

class HomeworkItem extends StatelessWidget {
  final homework.HomeworkItem homeworkItem;

  HomeworkItem(this.homeworkItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
      child: Container(
        height: 100,
        child: Card(
          clipBehavior: Clip.hardEdge,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 100,
                width: 5,
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        homeworkItem.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        homeworkItem.description,
                        style: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text('Math'),
                      Text('Type: Test'),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.calendar_today,
                      size: 18,
                    ),
                    SizedBox(width: 5),
                    Text('22/06/19'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}