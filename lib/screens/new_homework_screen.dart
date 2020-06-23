import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
  HomeworkType _type = HomeworkType.homework;
  DateTime _selectedDate;
  FocusNode titleNode;
  FocusNode descriptionNode;
  


  List<String> listOfClasses = [];

  @override
  void initState() {
    super.initState();

    titleNode = FocusNode();
    descriptionNode = FocusNode();
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
        setState(() {
          _type = recivedValue;
        });
      },
    );
  }

  void _presentDatePicker() {
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

  void _addHomework(){

    Provider.of<Homework>(context, listen: false).addItem(
      id: DateTime.now().toString(),
      title: titleController.text,
      description: descriptionController.text,
      selectedClass: _classValue,
      date: _selectedDate,
      type: _type,
    );
    Navigator.of(context).pop();
    
  }

  void _unFocusNode(){
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {

    listOfClasses = Provider.of<Classes>(context, listen: false).items.map((item) => item.name).toList();
    
    if(!tapOnClass){
      setState(() {
        _classValue = listOfClasses[0];
      });
    }
    

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'New Homework',
          style: TextStyle(fontWeight: FontWeight.w300),
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
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      ),
                      onSubmitted: (_){
                        FocusScope.of(context).requestFocus(descriptionNode);
                      },
                    ),
                    CustomDivider('Description'),
                    TextField(
                      focusNode: descriptionNode,
                      controller: descriptionController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      ), 
                    ),
                    CustomDivider('Class'),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: DropdownButton<String>(
                        value: _classValue,
                        items: listOfClasses.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(value),
                            ),
                          );
                        }).toList(),
                        onTap: (){
                          _unFocusNode();
                          tapOnClass = true;
                        },
                        onChanged: (value) {
                          
                          setState(() {
                            _classValue = value;
                          });
                        },
                        isExpanded: true,
                        underline: Container(),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Text(
                            'Due Date',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        RaisedButton(
                          onPressed: _presentDatePicker,
                          child: Text(_selectedDate != null
                              ? DateFormat.yMMMMEEEEd().format(_selectedDate)
                              : 'Pick a Date'),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        Expanded(child: SizedBox()),
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
            height: 40,
            width: double.infinity,
            child: RaisedButton(
              child: Text('Save'),
              color: Theme.of(context).accentColor,
              onPressed: _addHomework,
            ),
          ),
        ],
      ),
    );
  }
}
