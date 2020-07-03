import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


class ClassesItem {
  String id;
  String name;
  String teacherName;
  Map<String, Map<String, dynamic>> schedule;
  Color color;

  ClassesItem({
    this.id,
    this.name,
    this.teacherName,
    this.schedule,
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
    Map<String, Map<String, dynamic>> scheduleItem,
    Color color,
  }) {
    _items.add(
      ClassesItem(
        id: id,
        name: name,
        teacherName: teacherName,
        schedule: scheduleItem,
        color: color,
      ),
    );
    print(id);
    notifyListeners();
  }
}
