import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import './new_classes_screen.dart';
import '../providers/homework.dart';
import '../providers/classes.dart';
import '../widgets/custom_divider.dart';

class NewHomeworkScreen extends StatefulWidget {
  static const routeName = '/new-homework';

  @override
  _NewHomeworkScreenState createState() => _NewHomeworkScreenState();
}

class _NewHomeworkScreenState extends State<NewHomeworkScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  String _classValue;
  bool tapOnClass = false;
  Map<String, dynamic> _initValue = {
    'id': null,
    'title': '',
    'description': '',
    'dueDate': null,
    'type': null,
  };
  HomeworkType _type = HomeworkType.homework;
  DateTime _selectedDate;
  FocusNode titleNode;
  FocusNode descriptionNode;
  var _isInit = true;

  List<ClassesItem> listOfClasses = [];
  Map<String, Color> mapOfClasses = {};

  @override
  void initState() {
    super.initState();

    titleNode = FocusNode();
    descriptionNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    if (_isInit) {
      final _item = ModalRoute.of(context).settings.arguments as HomeworkItem;

      if (_item != null) {
        _initValue = {
          'id': _item.id,
          'title': _item.title,
          'description': _item.description,
          'dueDate': _item.dueDate,
          'type': _item.type,
          'assignature': _item.asignature,
        };
        titleController.text = _initValue['title'];
        descriptionController.text = _initValue['description'];
        _classValue = _initValue['assignature'];
        _selectedDate = _initValue['dueDate'];
        _type = _initValue['type'];
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    titleNode.dispose();
    descriptionNode.dispose();

    super.dispose();
  }

  Widget _radioList(String text, HomeworkType recivedValue) {
    return ListTile(
      title: Text(text),
      leading: Radio(
        value: recivedValue,
        groupValue: _type,
        onChanged: (HomeworkType value) {
          setState(() {
            _type = value;
          });
        },
      ),
      onTap: () {
        _unSelectClass(false);
        setState(() {
          _type = recivedValue;
        });
      },
    );
  }

  void _presentDatePicker() {
    _unSelectClass(false);
    _unFocusNode();
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2099),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
  }

  Widget _optionButton(String name, Color color) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pop();
        if (color != null) {
          setState(() {
            _classValue = name;
          });
        } else {
          Navigator.of(context).pushNamed(NewClassesScreen.routeName);
        }
      },
      title: Text(
        name,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
      ),
      trailing: Icon(
        color != null ? Icons.class_ : Icons.add,
        color: color != null ? color : Theme.of(context).accentColor,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }

  void _presentClassPicker(Map<String, Color> classes) {
    _unFocusNode();
    showDialog(
      context: context,
      builder: (BuildContext) => AlertDialog(
        title: Text(
          'Select a class',
          style: TextStyle(
              fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w600),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
        ],
        content: Container(
          height: 200,
          width: 300,
          child: ListView.builder(
            // physics: const NeverScrollableScrollPhysics(),
            itemCount: classes.length,
            itemBuilder: (ctx, index) => _optionButton(
              classes.keys.toList()[index],
              classes[classes.keys.toList()[index]],
            ),
          ),
        ),
      ),
    );
  }

  void _addHomework() {
    Provider.of<Homework>(context, listen: false).addItem(
      id: _initValue['id'] != null
          ? _initValue['id']
          : DateTime.now().toString(),
      title: titleController.text,
      description: descriptionController.text,
      selectedClass: _classValue,
      date: _selectedDate,
      type: _type,
    );
    Navigator.of(context).pushReplacementNamed('/');
  }

  void _unFocusNode() {
    FocusScope.of(context).unfocus();
  }

  void _unSelectClass(bool isSelected) {
    setState(() {
      tapOnClass = isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    listOfClasses = Provider.of<Classes>(context, listen: false)
        .items
        .map((item) => item)
        .toList();

    listOfClasses.forEach((item) {
      mapOfClasses.putIfAbsent(item.name, () => item.color);
    });
    mapOfClasses.putIfAbsent("Add a new class", () => null);

    // if (!tapOnClass && _classValue == null) {
    //   setState(() {
    //     _classValue = listOfClasses[0];
    //   });
    // }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'New Homework',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CustomDivider('Title'),
                    TextField(
                      autofocus: true,
                      focusNode: titleNode,
                      controller: titleController,
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
                      onTap: () {
                        _unSelectClass(false);
                      },
                      onSubmitted: (_) {
                        FocusScope.of(context).requestFocus(descriptionNode);
                      },
                    ),
                    CustomDivider('Description'),
                    TextField(
                      focusNode: descriptionNode,
                      controller: descriptionController,
                      maxLines: 5,
                      onTap: () {
                        _unSelectClass(false);
                      },
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor, width: 1.0),
                        ),
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      ),
                    ),
                    // CustomDivider('Class'),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Text(
                            'Class',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        Expanded(
                          child: RaisedButton(
                            onPressed: () {
                              _presentClassPicker(mapOfClasses);
                            },
                            child: Text(_classValue != null
                                ? _classValue
                                : 'Select a class'),
                            color: Colors.white,
                            textColor: Theme.of(context).accentColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Container(
                    //   decoration: BoxDecoration(
                    //       border: Border.all(
                    //         color: tapOnClass
                    //             ? Theme.of(context).accentColor
                    //             : Colors.grey[800],
                    //         width: 1,
                    //       ),
                    //       borderRadius: BorderRadius.all(Radius.circular(5))),
                    //   child: DropdownButton<String>(
                    //     value: _classValue,
                    //     items: listOfClasses
                    //         .map<DropdownMenuItem<String>>((String value) {
                    //       return DropdownMenuItem<String>(
                    //         value: value,
                    //         child: Padding(
                    //           padding: const EdgeInsets.all(15),
                    //           child: Text(value),
                    //         ),
                    //       );
                    //     }).toList(),
                    //     onTap: () {
                    //       _unFocusNode();
                    //       _unSelectClass(true);
                    //     },
                    //     onChanged: (value) {
                    //       setState(() {
                    //         _classValue = value;
                    //         tapOnClass = true;
                    //       });
                    //     },
                    //     isExpanded: true,
                    //     underline: Container(),
                    //   ),
                    // ),
                    SizedBox(height: 5),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Text(
                            'Due Date',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        Expanded(
                          child: RaisedButton(
                            onPressed: _presentDatePicker,
                            child: Text(_selectedDate != null
                                ? DateFormat.yMMMMEEEEd().format(_selectedDate)
                                : 'Pick a Date'),
                            color: Colors.white,
                            textColor: Theme.of(context).accentColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    CustomDivider('Type'),
                    Column(
                      children: <Widget>[
                        _radioList('Homework', HomeworkType.homework),
                        _radioList('Proyect', HomeworkType.proyect),
                        _radioList('Test', HomeworkType.test),
                      ],
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
              onPressed: _addHomework,
            ),
          ),
        ],
      ),
    );
  }
}
