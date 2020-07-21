import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/next_class_card.dart';
import '../widgets/schedule_card.dart';
import '../providers/classes.dart';

class ScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final day = DateTime.now().weekday - 1;

    final classProvider = Provider.of<Classes>(context, listen: false);
    final classes = classProvider.getDaySchedule(day);
    final days = classProvider.days;
    //final nextClass = classProvider.getNextClass(days[day]);

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              'My Schedule',
              style: Theme.of(context).textTheme.headline6,
            ),
            leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.grey[200],
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.only(
                  top: 90,
                  bottom: 15,
                ),
                child: NextClassCard(
                  'Spanish',
                  Colors.purple,
                  '10:00 PM',
                  'SC11',
                ),
              ),
            ),
            floating: true,
            expandedHeight: 200,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    days[day],
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    classes.length < 1
                        ? 'You have no classes'
                        : classes.length > 1
                            ? 'You have ${classes.length} classes'
                            : 'You have ${classes.length} class',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) => ScheduleCard(
                  classes[i].name,
                  classes[i].schedule[days[day]]['Start'].format(ctx),
                  classes[i].schedule[days[day]]['Finish'].format(ctx),
                  classes[i].schedule[days[day]]['Classroom'],
                  classes[i].teacherName,
                  classes[i].color),
              childCount: classes.length,
            ),
          ),
        ],
      ),

      // body: Center(
      //   child: ListView.builder(
      //     itemCount: classes.length,
      //     itemBuilder: (ctx, i) => ScheduleCard(
      //         classes[i].name,
      //         classes[i].schedule[days[day]]['Start'].format(ctx),
      //         classes[i].schedule[days[day]]['Finish'].format(ctx),
      //         classes[i].schedule[days[day]]['Classroom'],
      //         classes[i].teacherName,
      //         classes[i].color),
      //   ),
      // ),
    );
  }
}
