import 'dart:io';

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
  bool _isFromNew;
  bool _isFromNewTask;
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
  var _isEditing;
  bool _hasASchedule = false;
  final _formKey = GlobalKey<FormState>();

  Color classColor;
  Color classError = Colors.blueAccent[400];

  void _colorPicker(Color color) {
    setState(() {
      classColor = color;
      classError = Colors.white;
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
      final recivedClass =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      final _item =
          recivedClass['isClassItem'] ? recivedClass['classItem'] : null;

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
        classError = Colors.white;
        _isEditing = true;
      } else {
        _isEditing = false;
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

  bool _nameExist(String name) {
    var listOfClasses = Provider.of<Classes>(context, listen: false)
        .items
        .map((item) => item)
        .toList();

    for (var i = 0; i < listOfClasses.length; i++) {
      if (listOfClasses[i].name == name) {
        return true;
      }
    }
    return false;
  }

  void _showColorPicker() {
    _unFocusNode();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Pick a color',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
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
                classColor = classColor;
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

  void _deleteDayFromSchedule(String dia) {
    showDialog(
      context: context,
      builder: (BuildContext) => AlertDialog(
        title: Text(
          'Want to delete this day?',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                newSchedule.remove(dia);
              });
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          )
        ],
        content: Text(
            "This action will remove the day from the schedule. You can add it later."),
      ),
    );
  }

  void _addClasses(){
    final isValid = _formKey.currentState.validate();
    final colorValid = classColor != null;
    final isScheduleValid = newSchedule != null;

    var isAllValid = true;

    if (!isValid) {
      isAllValid = false;
    }
    if (!colorValid) {
      setState(() {
        classError = Colors.red;
      });
      isAllValid = false;
    }
    if (!isScheduleValid) {
      setState(() {
        _hasASchedule = true;
      });
      isAllValid = false;
    }
    if (!isAllValid) {
      return;
    }

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
    
    if (!_isFromNew)
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    if (_isFromNew && _isFromNewTask) {
      Navigator.of(context).pop();
    }else{
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    }
  }

  Widget _scheduleCard({String dia, Map<String, dynamic> hour, bool haveDay}) {
    return InkWell(
      onLongPress: haveDay
          ? () {
              _deleteDayFromSchedule(dia);
            }
          : null,
      onTap: () async {
        setState(() {
          _hasASchedule = false;
        });
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
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 10,
        ),
        child: haveDay
            ? FittedBox(
                child: Column(
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
                    // Column(
                    //   children: <Widget>[
                    Text(
                      '${hour['Classroom']}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        // color: Theme.of(context).primaryColor
                      ),
                    ),
                    Text(
                      '${hour['Start'].format(context)} - ${hour['Finish'].format(context)}',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300
                          // color: Theme.of(context).primaryColor,
                          ),
                    ),
                    //   ],
                    // ),
                  ],
                ),
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
    final Map<String, dynamic> recivedItem =
        ModalRoute.of(context).settings.arguments;
    ClassesItem classItem;
    if (recivedItem["isClassItem"]) {
      classItem = recivedItem["classItem"];
      _isFromNew = false;
    }
    if (!recivedItem["isClassItem"]){
      _isFromNew = true;
      _isFromNewTask = recivedItem["isFromNewTask"] ? true : false;
    } 

    final classes = Provider.of<Classes>(context, listen: false);
    final homework = Provider.of<Homework>(context, listen: false);

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
        actions: [
          if (recivedItem["isClassItem"])
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext) => AlertDialog(
                      title: Text(
                        'Are you sure?',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            classes.deleteItem(classItem.id);
                            homework.deleteByClassName(classItem.name);
                            Navigator.of(context)
                                .pushNamedAndRemoveUntil('/', (route) => false);
                          },
                          child: Text('OK'),
                        )
                      ],
                      content: Text("This action cannot be undone."),
                    ),
                  );
                }),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CustomDivider('Class Name'),
                      TextFormField(
                        autofocus: false,
                        textCapitalization: TextCapitalization.sentences,
                        focusNode: _classNode,
                        controller: _classController,
                        decoration: InputDecoration(
                          // labelText: 'Title',
                          // labelStyle: TextStyle(
                          //     fontSize: 20, fontWeight: FontWeight.bold),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 1.0),
                          ),
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        ),
                        onFieldSubmitted: (_) {
                          _focusNextNode(_teacherNode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide the name of the class';
                          }
                          if (_nameExist(value)) {
                            return _isEditing
                                ? null
                                : 'That class already exist';
                          }
                          return null;
                        },
                      ),
                      CustomDivider('Teacher Name'),
                      TextFormField(
                        autofocus: false,
                        textCapitalization: TextCapitalization.sentences,
                        focusNode: _teacherNode,
                        controller: _teacherController,
                        decoration: InputDecoration(
                          // labelText: 'Title',
                          // labelStyle: TextStyle(
                          //     fontSize: 20, fontWeight: FontWeight.bold),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 1.0),
                          ),
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        ),
                        onFieldSubmitted: (_) {
                          _focusNextNode(_classroomNode);
                        },
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Please provide the name of the teacher';
                        //   }
                        //   return null;
                        // },
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
                            color:
                                classColor != null ? classColor : Colors.white,
                            textColor: classError,
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
                      if (_hasASchedule)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Text(
                            'Please add a schedule',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      Container(
                        width: double.infinity,
                        height: 400,
                        child: GridView(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 10),
                          children: daysList,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 5 / 2,
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
