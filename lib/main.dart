import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import './providers/schedule.dart';
import './screens/add_schedule_screen.dart';
import './screens/new_homework_screen.dart';
import './screens/tabs_screen.dart';
import './screens/new_classes_screen.dart';
import './screens/classes_detail_screen.dart';
import './providers/homework.dart';
import './providers/classes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Homework(),
        ),
        ChangeNotifierProvider(
          create: (_) => Classes(),
        ),
        ChangeNotifierProvider(
          create: (_) => Schedule(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.blue[900],
          accentColor: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: TabsScreen(),
        routes: {
          NewHomeworkScreen.routeName: (ctx) => NewHomeworkScreen(),
          NewClassesScreen.routeName: (ctx) => NewClassesScreen(),
          ClassesDetailScreen.routeName: (ctx) => ClassesDetailScreen(),
          AddScheduleScreen.routeName: (ctx) => AddScheduleScreen(),
        },
      ),
    );
  }
}
