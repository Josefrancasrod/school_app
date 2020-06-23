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
    
  ];

  List<ClassesItem> get items {
    return [..._items];
  }

  void addItem({
    String id,
    String name,
    String teacherName,
    String classroom,
    Color color,
  }) {
    _items.add(
      ClassesItem(
        id: id,
        name: name,
        teacherName: teacherName,
        classroom: classroom,
        color: color,
      ),
    );
    print(id);
    notifyListeners();
  }
}
