import 'package:flutter/material.dart';

enum HomeworkType {
  homework,
  proyect,
  test,
}

class HomeworkItem {
  String id;
  String title;
  String description;
  String idMateria;
  DateTime dueDate;
  String type;

  HomeworkItem({
    this.id,
    this.title,
    this.description,
    this.idMateria,
    this.dueDate,
    this.type,
  });
}

class Homework with ChangeNotifier {
  Map<String, HomeworkItem> _items = {
    '1': HomeworkItem(
      id: DateTime.now().toString(),
      title: 'Math problems',
      description: 'Problems of the page 201',
    ),
    '2': HomeworkItem(
      id: DateTime.now().toString(),
      title: 'Code Problems',
      description: 'Problems of the page 201',
    ),
    '3': HomeworkItem(
      id: DateTime.now().toString(),
      title: 'Definitions',
      description: 'Problems of the page 201',
    ),
    '4': HomeworkItem(
      id: DateTime.now().toString(),
      title: 'Math problems',
      description: 'Problems of the page 201',
    ),
    '5': HomeworkItem(
      id: DateTime.now().toString(),
      title: 'More Math problems',
      description: 'Problems of the page 201',
    ),
  };

  int get itemCount {
    return _items.length;
  }

  Map<String, HomeworkItem> get items {
    return {..._items};
  }
}
