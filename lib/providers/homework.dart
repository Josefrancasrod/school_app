import 'package:flutter/material.dart';
import 'package:school_app/widgets/homework_item.dart';

import '../helpers/db_helper.dart';

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
  HomeworkType _getHomeworkType(int type) => type == 0
      ? HomeworkType.homework
      : type == 1 ? HomeworkType.proyect : HomeworkType.test;

  Map<String, HomeworkItem> _items = {};

  Future<void> addItem({
    String id,
    String title,
    String description,
    String selectedClass,
    DateTime date,
    HomeworkType type,
  }) {
    HomeworkItem newHomework = HomeworkItem(
      id: id,
      title: title,
      description: description,
      asignature: selectedClass,
      dueDate: date,
      type: type,
    );

    if (_items.containsKey(id)) {
      _items.update(
        id,
        (value) => newHomework,
      );
      DBHelper.update(
        newHomework.id,
      'homework',
      {
        'id': newHomework.id,
        'title': newHomework.title,
        'description': newHomework.description,
        'sclass': newHomework.asignature,
        'date': newHomework.dueDate.toIso8601String(),
        'type': newHomework.type.index,
      },
    );
    } else {
      _items.putIfAbsent(
        id,
        () => newHomework,
      );
      DBHelper.insert(
        'homework',
        {
          'id': newHomework.id,
          'title': newHomework.title,
          'description': newHomework.description,
          'sclass': newHomework.asignature,
          'date': newHomework.dueDate.toIso8601String(),
          'type': newHomework.type.index,
        },
      );

      return null;
    }
    notifyListeners();
    // print(newHomework.type.index);
  }

  Future<void> fetchAndSetHomework() async {
    final homeworkList = await DBHelper.getData('homework');

    homeworkList.forEach((item) {
      _items.putIfAbsent(
        item['id'],
        () => HomeworkItem(
          id: item['id'],
          title: item['title'],
          description: item['description'],
          asignature: item['sclass'],
          dueDate: DateTime.parse(item['date']),
          type: _getHomeworkType(item['type']),
        ),
      );
    });

    notifyListeners();
  }

  void deleteItem(String id) {
    _items.removeWhere((key, value) => value.id == id);
    DBHelper.deleteHomework(id);
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

  Map<String, HomeworkItem> itemsFiltered(Map <String, dynamic> filters) {
    //filters should be
    //{
    //  isFilterByDate: true/false
    //  isFilterBYName: string
    //  filterInfo: dateLastToNow/dateFromNowToLast/className     
    //}
  
    Map<String, HomeworkItem> listOfHomework = {};
    /*_items.forEach((key, value) {
      if (value.asignature == name) {
        listOfHomework.putIfAbsent(key, () => value);
      }
    });
    */
    return listOfHomework;
  }

  Map<String, HomeworkItem> get items {
    return {..._items};
  }
}
