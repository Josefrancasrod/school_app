import 'package:flutter/material.dart';

import '../providers/homework.dart' as homework;

class HomeworkItem extends StatelessWidget {
  final homework.HomeworkItem homeworkItem;

  HomeworkItem(this.homeworkItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(homeworkItem.title),
        ),
      ),
    );
  }
}
