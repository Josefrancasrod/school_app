import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';

import '../providers/homework.dart';
import '../widgets/custom_divider.dart';
import '../providers/classes.dart';
import '../screens/add_schedule_screen.dart';

class NewClassesScreen extends StatefulWidget {
  static const routeName = '/New-Classes-Screen';

  @override
  _NewClassesScreenState createState() => _NewClassesScreenState();
}

class _NewClassesScreenState extends State<NewClassesScreen> {
  final _classController = TextEditingController();
  final _teacherController = TextEditingController();
  // final _classroomController = TextEditingController();
  Map<String, Map<String, dynamic>> newSchedule;
  Map<String, dynamic> _initValue = {
    'id': null,
    'name': '',
    'teacher': null,
    'color': null,
    'schedule': null,
  };

  FocusNode _classNode;
  FocusNode _teacherNode;
  FocusNode _classroomNode;
  String _oldName;
  var _isInit = true;

  Color classColor = Colors.red;

  void _colorPicker(Color color) {
    setState(() {
      classColor = color;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _classNode = FocusNode();
    _teacherNode = FocusNode();
    _classroomNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    if (_isInit) {
      final _item = ModalRoute.of(context).settings.arguments as ClassesItem;

      if (_item != null) {
        _initValue = {
          'id': _item.id,
          'name': _item.name,
          'teacher': _item.teacherName,
          'color': _item.color,
          'schedule': _item.schedule,
        };
        _oldName = _initValue['name'];
        _classController.text = _initValue['name'];
        _teacherController.text = _initValue['teacher'];
        classColor = _initValue['color'];
        newSchedule = _initValue['schedule'];
      }
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _classNode.dispose();
    _teacherNode.dispose();
    _classroomNode.dispose();

    super.dispose();
  }

  void _showColorPicker() {
    _unFocusNode();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pick a color'),
        content: Container(
          height: 200,
          child: MaterialColorPicker(
            onColorChange: _colorPicker,
            selectedColor: classColor,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              setState(() {
                classColor = Colors.red;
              });
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'OK',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _focusNextNode(FocusNode focus) {
    FocusScope.of(context).requestFocus(focus);
  }

  void _unFocusNode() {
    FocusScope.of(context).unfocus();
  }

  void _addClasses() {
    Provider.of<Classes>(context, listen: false).addItem(
      id: _initValue['id'] != null
          ? _initValue['id']
          : DateTime.now().toString(),
      name: _classController.text,
      teacherName: _teacherController.text,
      scheduleItem: newSchedule,
      color: classColor,
    );
    if (_oldName != null) {
      Provider.of<Homework>(context, listen: false).editClassName(
        _oldName,
        _classController.text,
      );
    }

    Navigator.of(context).pushReplacementNamed('/');
  }

  Widget _scheduleCard({String dia, Map<String, dynamic> hour, bool haveDay}) {
    return InkWell(
      onTap: () async {
        final scheduleItem =
            await Navigator.pushNamed(context, AddScheduleScreen.routeName)
                as Map<String, Map<String, dynamic>>;
        setState(() {
          if (newSchedule == null) {
            newSchedule = scheduleItem;
          } else {
            scheduleItem.forEach((key, value) {
              if (newSchedule.containsKey(key)) {
                newSchedule.update(key, (v) => value);
              } else {
                newSchedule.putIfAbsent(key, () => value);
              }
            });
          }
        });
      },
      splashColor: classColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: haveDay
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    dia,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: classColor),
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        '${hour['Classroom']}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          // color: Theme.of(context).primaryColor
                        ),
                      ),
                      Text(
                        '${hour['Start'].format(context)} - ${hour['Finish'].format(context)}',
                        style: TextStyle(
                          fontSize: 10,
                          // color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Center(
                child: Icon(
                Icons.add,
                color: Colors.grey,
              )),
        decoration: haveDay
            ? BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border:
                    Border.all(width: 1, color: Theme.of(context).accentColor),
              )
            : BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 2, color: Colors.grey),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> daysList = [];

    if (newSchedule != null) {
      newSchedule.forEach((key, value) {
        daysList.add(_scheduleCard(dia: key, hour: value, haveDay: true));
      });
      if (daysList.length < 6) {
        daysList.add(_scheduleCard(haveDay: false));
      }
    } else {
      daysList.add(_scheduleCard(haveDay: false));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Class',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CustomDivider('Class Name'),
                    TextField(
                      autofocus: true,
                      focusNode: _classNode,
                      controller: _classController,
                      decoration: InputDecoration(
                        // labelText: 'Title',
                        // labelStyle: TextStyle(
                        //     fontSize: 20, fontWeight: FontWeight.bold),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor, width: 1.0),
                        ),
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      ),
                      onSubmitted: (_) {
                        _focusNextNode(_teacherNode);
                      },
                    ),
                    CustomDivider('Teacher Name'),
                    TextField(
                      focusNode: _teacherNode,
                      controller: _teacherController,
                      decoration: InputDecoration(
                        // labelText: 'Title',
                        // labelStyle: TextStyle(
                        //     fontSize: 20, fontWeight: FontWeight.bold),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor, width: 1.0),
                        ),
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      ),
                      onSubmitted: (_) {
                        _focusNextNode(_classroomNode);
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Text(
                            'Class Color',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        RaisedButton(
                          onPressed: _showColorPicker,
                          child: Text('Pick a Color'),
                          color: classColor,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(),
                        ),
                      ],
                    ),
                    CustomDivider('Add a schedule'),
                    Container(
                      width: double.infinity,
                      height: 200,
                      child: GridView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 10),
                        children: daysList,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 150,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 70,
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: RaisedButton(
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                ),
              ),
              color: Theme.of(context).accentColor,
              onPressed: _addClasses,
            ),
          ),
        ],
      ),
    );
  }
}
