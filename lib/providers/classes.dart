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
  double _timeOfDayToDouble(TimeOfDay timeOfDay) =>
      timeOfDay.hour + timeOfDay.minute / 60.0;
  List<ClassesItem> _items = [];
  List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  List<ClassesItem> get items {
    return [..._items];
  }

  List<ClassesItem> _orderItemsByDay(int day) {
    final daySchedule = _items.where((element) {
      final listOfKey = element.schedule.keys.toList();
      String mapDay;

      listOfKey.forEach((element) {
        if (element == days[day]) {
          mapDay = element;
        }
      });
      return mapDay == days[day];
    });

    return [...daySchedule];
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

  List<ClassesItem> getDaySchedule(int day) {
    List<ClassesItem> daySchedule = _orderItemsByDay(day);
    ClassesItem aux;

    for (var i = 0; i < daySchedule.length; i++) {
      var startHour =
          _timeOfDayToDouble(daySchedule[i].schedule[days[day]]['Start']);

      for (var j = 0; j < daySchedule.length; j++) {
        var nextStartHour =
            _timeOfDayToDouble(daySchedule[j].schedule[days[day]]['Start']);

        if (startHour < nextStartHour) {
          aux = daySchedule[i];
          daySchedule[i] = daySchedule[j];
          daySchedule[j] = aux;
        }
      }
    }

    return daySchedule;
  }
}
