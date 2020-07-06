import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/add_schedule_screen.dart';
import '../providers/classes.dart';

class ScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final classProvider = Provider.of<Classes>(context, listen: false);
    final classes = classProvider.getDaySchedule(DateTime.now());
    final days = classProvider.days;

    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: classes.length,
          itemBuilder: (ctx, i) => Card(
            child: Column(
              children: <Widget>[
                Text(classes[i].name),
                Text('${classes[i].schedule[days[3]]['Start'].format(ctx)} - ${classes[i].schedule[days[3]]['Finish'].format(ctx)}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
