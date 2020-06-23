import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ClassesItem {
  String id;
  String name;
  String schedule;
  String teacherName;
  String classroom;
  Color color;

  ClassesItem({
    this.id,
    this.name,
    this.schedule,
    this.teacherName,
    this.classroom,
    this.color,
  });
}

class Classes with ChangeNotifier {
  List<ClassesItem> _items = [
    ClassesItem(
      id: DateTime.now().toString(),
      name: 'Math',
      color: Colors.blue,
    ),
    ClassesItem(
      id: DateTime.now().toString(),
      name: 'Science',
      color: Colors.green,
    ),
    ClassesItem(
      id: DateTime.now().toString(),
      name: 'Spanish',
      color: Colors.red,
    ),
    ClassesItem(
      id: DateTime.now().toString(),
      name: 'English',
      color: Colors.orange,
    ),
  ];

  List<ClassesItem> get items {
    return [..._items];
  }

}
