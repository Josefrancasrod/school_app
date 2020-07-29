import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/classes_screen.dart';
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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: TextTheme(
            bodyText1: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
            bodyText2: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 15,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
            headline6: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
            subtitle1: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w300,
            ),
          ),
          primaryColor: Colors.grey[200],
          accentColor: Colors.blueAccent[400],
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: TabsScreen(),
        routes: {
          NewHomeworkScreen.routeName: (ctx) => NewHomeworkScreen(),
          NewClassesScreen.routeName: (ctx) => NewClassesScreen(),
          ClassesDetailScreen.routeName: (ctx) => ClassesDetailScreen(),
          AddScheduleScreen.routeName: (ctx) => AddScheduleScreen(),
          ClassesScreen.routeName: (ctx) => ClassesScreen(),
        },
      ),
    );
  }
}
