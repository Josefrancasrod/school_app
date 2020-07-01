import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_divider.dart';
import '../providers/schedule.dart';

enum ButtomType {
  start,
  finish,
}

class AddScheduleScreen extends StatefulWidget {
  static const routeName = '/add-schedule-screen';
  Map<String, bool> isSelected = {
    'Monday': false,
    'Tuesday': false,
    'Wednesday': false,
    'Thursday': false,
    'Friday': false,
    'Saturday': false,
  };

  @override
  _AddScheduleScreenState createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  final _classroomController = TextEditingController();

  TimeOfDay start, finish, entry;
  List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  void _timePicker(ButtomType type) async {
    TimeOfDay entry = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (entry != null) {
      switch (type) {
        case ButtomType.start:
          setState(() {
            start = entry;
          });
          break;
        case ButtomType.finish:
          setState(() {
            finish = entry;
          });
          break;
      }
    }
  }

  void _saveSchedule(Map<String, bool> isSelected, List<TimeOfDay> time) {
    final schedule = Provider.of<Schedule>(context, listen: false);
    Map<String, Map<String, dynamic>> newSchedule = {};

    for (var i = 0; i < days.length; i++) {
      if (isSelected[days[i]]) {
        newSchedule.putIfAbsent(
            days[i],
            () => {
                  'Start': time[0],
                  'Finish': time[1],
                  'Classroom': _classroomController.text,
                });
      }
    }

    schedule.addSchedule(
      ScheduleItem(
        id: DateTime.now().toString(),
        weekschedule: newSchedule,
      ),
    );
  }

  Widget _filterChip(String text) {
    return FilterChip(
      label: Container(
        width: 60,
        child: Center(child: Text(text)),
      ),
      labelStyle: TextStyle(
        color: widget.isSelected[text] ? Colors.black : Colors.black54,
        fontSize: 10,
      ),
      selected: widget.isSelected[text],
      onSelected: (bool selected) {
        setState(() {
          widget.isSelected[text] = !widget.isSelected[text];
        });
      },
      selectedColor: Theme.of(context).accentColor,
      checkmarkColor: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'New Schedule',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    CustomDivider('Pick the days'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            _filterChip('Monday'),
                            _filterChip('Tuesday'),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            _filterChip('Wednesday'),
                            _filterChip('Thursday'),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            _filterChip('Friday'),
                            _filterChip('Saturday'),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Text(
                            'Pick a time',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        RaisedButton(
                          onPressed: () {
                            _timePicker(ButtomType.start);
                          },
                          child: Text(start == null
                              ? 'Start'
                              : '${start.format(context)}'),
                          textColor: Colors.white,
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        RaisedButton(
                          onPressed: () {
                            _timePicker(ButtomType.finish);
                          },
                          child: Text(finish == null
                              ? 'Finish'
                              : '${finish.format(context)}'),
                          textColor: Colors.white,
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ],
                    ),
                    CustomDivider('Classroom'),
                    TextField(
                      controller: _classroomController,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 40,
            width: double.infinity,
            child: RaisedButton(
              color: Theme.of(context).accentColor,
              child: Text('Save'),
              onPressed: () {
                _saveSchedule(widget.isSelected, [start, finish]);
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }
}
