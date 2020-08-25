import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../helpers/db_helper.dart';

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
  TimeOfDay _timeOfDayFromString(String time) => TimeOfDay(hour: int.parse('${time.split(':')[0]}'), minute: int.parse('${time.split(':')[1]}'));
  List<ClassesItem> _items = [];
  List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
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
    }); //  POSIBLE O(n2)

    return [...daySchedule];
  }

  void addItem({
    String id,
    String name,
    String teacherName,
    Map<String, Map<String, dynamic>> scheduleItem,
    Color color,
  }) {
    var newClasses = ClassesItem(
      id: id,
      name: name,
      teacherName: teacherName,
      schedule: scheduleItem,
      color: color,
    );

    var index = _items.indexWhere((element) => element.id == id);

    if (index >= 0) {
      _items[index].name = name;
      _items[index].teacherName = teacherName;
      _items[index].color = color;
      _items[index].schedule = scheduleItem;
    } else {
      _items.add(newClasses);
    }

    notifyListeners();
    DBHelper.insert(
      'classes',
      {
        'id': newClasses.id,
        'title': newClasses.name,
        'teacher': newClasses.teacherName,
        'color': newClasses.color.value,
      },
    );
    _insertSchedule(id, newClasses.schedule);
  }

  void deleteItem(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void _insertSchedule(String id, Map<String, dynamic> schedule) {
    schedule.forEach((key, value) async {
      await DBHelper.insert('schedule', {
        'idClass': id,
        'start':
            '${schedule[key]['Start'].hour}:${schedule[key]['Start'].minute}',
        'finish':
            '${schedule[key]['Finish'].hour}:${schedule[key]['Finish'].minute}',
        'classroom': schedule[key]['Classroom'],
        'day': key,
      });
    });

  }

  Future<void> fetchAndSetClases() async {
    final classesList = await DBHelper.getData('classes');

    _items = classesList
        .map(
          (item) => ClassesItem(
            id: item['id'],
            name: item['title'],
            teacherName: item['teacher'],
            color: Color(item['color']),
          ),
        )
        .toList();
    _items.forEach((element) async{
      element.schedule = await _fetchSchedules(element.id);
    });
    notifyListeners();
  }

  Future<Map<String, Map<String, dynamic>>> _fetchSchedules(String id) async {
    final scheduleList = await DBHelper.getSchedule(id, 'schedule');
    Map<String, Map<String, dynamic>> classSchedule = {};

    for(var i=0; i<scheduleList.length; i++){}

    scheduleList.forEach((item) {
      classSchedule.putIfAbsent(item['day'], () => {
        'Start': _timeOfDayFromString(item['start']),
        'Finish': _timeOfDayFromString(item['finish']),
        'Classroom': item['classroom'],
      });
    });

    return classSchedule;
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

  ClassesItem getNextClass(String day) {
    ClassesItem nextClass;
    List<ClassesItem> daySchedule = getDaySchedule(DateTime.now().weekday - 1);
    try {
      nextClass = daySchedule.firstWhere(
        (element) =>
            _timeOfDayToDouble(element.schedule[day]['Start']) >
            _timeOfDayToDouble(TimeOfDay.now()),
      );
    } catch (e) {
      nextClass = null;
    }
    return nextClass;
  }
}
