import 'package:flutter/material.dart';

import '../screens/add_schedule_screen.dart';

class ScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Schedule'),
            RaisedButton(
              onPressed: () {
                //DELETE THIS AFTER TESTING
                Navigator.of(context).pushNamed(AddScheduleScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
