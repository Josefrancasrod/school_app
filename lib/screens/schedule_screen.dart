import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/schedule_card.dart';
import '../providers/classes.dart';

class ScheduleScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final day = DateTime.now().weekday;

    final classProvider = Provider.of<Classes>(context, listen: false);
    final classes = classProvider.getDaySchedule(day);
    final days = classProvider.days;
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: classes.length,
          itemBuilder: (ctx, i) => ScheduleCard(
              classes[i].name,
              classes[i].schedule[days[day]]['Start'].format(ctx),
              classes[i].schedule[days[day]]['Finish'].format(ctx),
              classes[i].schedule[days[day]]['Classroom'],
              classes[i].teacherName,
              classes[i].color),
        ),
      ),
    );
  }
}
