import 'package:flutter/material.dart';

class ScheduleItem {
  String id;
  String classId;
  Map<String, Map<String, dynamic>> weekschedule = {
    'Monday': {
      'Start': null,
      'Finish': null,
      'Classroom': null,
    },
    'Tuesday': {
      'Start': null,
      'Finish': null,
      'Classroom': null,
    },
    'Wednesday': {
      'Start': null,
      'Finish': null,
      'Classroom': null,
    },
    'Thursday': {
      'Start': null,
      'Finish': null,
      'Classroom': null,
    },
    'Friday': {
      'Start': null,
      'Finish': null,
      'Classroom': null,
    },
    'Saturday': {
      'Start': null,
      'Finish': null,
      'Classroom': null,
    },
  };

  ScheduleItem({
    this.id,
    this.classId,
    this.weekschedule,
  });
}

class Schedule with ChangeNotifier {
  List<ScheduleItem> _items = [];

  List<ScheduleItem> get items {
    return [..._items];
  }

  void addSchedule(ScheduleItem newItem){
    _items.add(newItem);
    notifyListeners();
  }
}
