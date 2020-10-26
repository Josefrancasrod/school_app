import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../screens/new_homework_screen.dart';
import '../providers/homework.dart' as homework;
import '../providers/classes.dart';

class HomeworkItem extends StatelessWidget {
  final homework.HomeworkItem homeworkItem;
  final Color color;

  HomeworkItem(this.homeworkItem, this.color);

  String _getType(homework.HomeworkType type) {
    var stringType = '';

    switch (type) {
      case homework.HomeworkType.homework:
        stringType = "Homework";
        break;
      case homework.HomeworkType.test:
        stringType = "Test";
        break;
      case homework.HomeworkType.proyect:
        stringType = "Proyect";
        break;
    }

    return stringType;
  }

  String _stringWithOutEnter(String description) {
    var cardDescription;
    var hasAnEnter = description.contains('\n');

    if (description.length < 30 && hasAnEnter) {
      cardDescription = description.split('\n')[0];
    } else if (description.length > 30 && hasAnEnter) {
      cardDescription = description.split('\n')[0].length < 30
          ? description.split('\n')[0]
          : description.split('\n')[0].substring(0, 30) + "...";
    } else {
      cardDescription = description.length < 30
          ? description
          : description.substring(0, 30) + "...";
    }

    return cardDescription;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115,
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(NewHomeworkScreen.routeName, arguments: homeworkItem);
        },
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FittedBox(
                          child: Text(
                            homeworkItem.title.length < 21
                                ? homeworkItem.title
                                : homeworkItem.title.substring(0, 20) + '...',
                            style: TextStyle(
                              color: color,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            _stringWithOutEnter(homeworkItem.description),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundColor: color,
                      radius: 10,
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '${_getType(homeworkItem.type)}',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.date_range,
                          size: 20,
                          color: color,
                        ),
                        SizedBox(width: 5),
                        Text(
                          homeworkItem.dueDate == null
                              ? 'No Date'
                              : DateFormat.MMMMd().format(homeworkItem.dueDate),
                          style: TextStyle(
                              color: color,
                              fontSize: 14,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
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
