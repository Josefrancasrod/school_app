import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/homework.dart' as homework;

class HomeworkItem extends StatelessWidget {
  final homework.HomeworkItem homeworkItem;

  HomeworkItem(this.homeworkItem);

  String _getType(homework.HomeworkType type){
    var stringType = '';
    
    switch(type){
      case homework.HomeworkType.homework: stringType = "Homework"; break;
      case homework.HomeworkType.test: stringType = "Test"; break;
      case homework.HomeworkType.proyect: stringType = "Proyect"; break;
    }
    
    return stringType;
  
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
      child: Container(
        height: 80,
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
                          fontSize: 20,
                        ),
                      ),
                      Text(homeworkItem.asignature),
                      Text('Type: ${_getType(homeworkItem.type)}'),
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
                      Icons.date_range,
                      size: 18,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(width: 5),
                    Text(DateFormat.yMMMMd().format(homeworkItem.dueDate)),
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
