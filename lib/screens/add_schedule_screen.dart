import 'package:flutter/material.dart';

import '../widgets/custom_divider.dart';

class AddScheduleScreen extends StatefulWidget {
  static const routeName = '/add-schedule-screen';
  bool isSelected = false;

  @override
  _AddScheduleScreenState createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  Widget _filterChip(String text) {
    return FilterChip(
        label: Text(text),
        labelStyle:
            TextStyle(color: widget.isSelected ? Colors.black : Colors.black54),
        selected: widget.isSelected,
        onSelected: (bool selected) {
          setState(() {
            widget.isSelected = !widget.isSelected;
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
                          onPressed: () {},
                          child: Text('Start'),
                          textColor: Colors.white,
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        RaisedButton(
                          onPressed: () {},
                          child: Text('Finish'),
                          textColor: Colors.white,
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ],
                    ),
                    CustomDivider('Room'),
                    TextField(
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
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
