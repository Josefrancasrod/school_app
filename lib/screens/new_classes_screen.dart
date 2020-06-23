import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_divider.dart';
import '../providers/classes.dart';

class NewClassesScreen extends StatefulWidget {
  static const routeName = '/New-Classes-Screen';

  @override
  _NewClassesScreenState createState() => _NewClassesScreenState();
}

class _NewClassesScreenState extends State<NewClassesScreen> {
  final _classController = TextEditingController();
  final _teacherController = TextEditingController();
  final _classroomController = TextEditingController();

  FocusNode _classNode;
  FocusNode _teacherNode;
  FocusNode _classroomNode;

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

  void _addClasses(){
    Provider.of<Classes>(context, listen: false).addItem(
      id: DateTime.now().toString(),
      name: _classController.text,
      teacherName: _teacherController.text,
      classroom: _classroomController.text,
      color: classColor,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Class'),
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
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      ),
                      onSubmitted: (_) {
                        _focusNextNode(_classroomNode);
                      },
                    ),
                    CustomDivider('Classroom'),
                    TextField(
                      autofocus: true,
                      focusNode: _classroomNode,
                      controller: _classroomController,
                      decoration: InputDecoration(
                        // labelText: 'Title',
                        // labelStyle: TextStyle(
                        //     fontSize: 20, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      ),
                      // onSubmitted: (_){
                      //   FocusScope.of(context).requestFocus(descriptionNode);
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
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
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
                        Expanded(child: SizedBox()),
                      ],
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
              child: Text('Save'),
              color: Theme.of(context).accentColor,
              onPressed: _addClasses,
            ),
          ),
        ],
      ),
    );
  }
}
