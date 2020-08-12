import 'package:flutter/material.dart';
import 'package:school_app/widgets/homework_item.dart';

enum HomeworkType {
  homework,
  proyect,
  test,
}

class HomeworkItem {
  String id;
  String title;
  String description;
  String asignature;
  DateTime dueDate;
  HomeworkType type;

  HomeworkItem({
    this.id,
    this.title,
    this.description,
    this.asignature,
    this.dueDate,
    this.type,
  });
}

class Homework with ChangeNotifier {
  Map<String, HomeworkItem> _items = {};

  void addItem({
    String id,
    String title,
    String description,
    String selectedClass,
    DateTime date,
    HomeworkType type,
  }) {
    if (_items.containsKey(id)) {
      _items.update(
        id,
        (value) => HomeworkItem(
          id: id,
          title: title,
          description: description,
          asignature: selectedClass,
          dueDate: date,
          type: type,
        ),
      );
    } else {
      _items.putIfAbsent(
        id,
        () => HomeworkItem(
          id: id,
          title: title,
          description: description,
          asignature: selectedClass,
          dueDate: date,
          type: type,
        ),
      );
    }
    notifyListeners();
  }

  void deleteItem(String id) {
    _items.removeWhere((key, value) => value.id == id);
    notifyListeners();
  }

  void deleteByClassName(String name) {
    _items.removeWhere((key, value) => value.asignature == name);
    notifyListeners();
  }

  void editClassName(String oldName, String newName) {
    var selectedKey;
    _items.forEach((key, value) {
      if (value.asignature == oldName) {
        selectedKey = key;
        return;
      }
    });
    if (selectedKey != null) {
      _items.update(
        selectedKey,
        (value) => HomeworkItem(
          asignature: newName,
          dueDate: value.dueDate,
          description: value.description,
          id: value.id,
          title: value.title,
          type: value.type,
        ),
      );
    }
  }

  int get itemCount {
    return _items.length;
  }

  int numberOfHomework(String name) {
    var totalHomework = 0;
    _items.forEach((key, value) {
      if (value.asignature == name) {
        totalHomework++;
      }
    });
    return totalHomework;
  }

  Map<String, HomeworkItem> get items {
    return {..._items};
  }
}
