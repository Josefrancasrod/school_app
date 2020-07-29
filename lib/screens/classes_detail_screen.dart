import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:school_app/providers/homework.dart';

import '../providers/classes.dart';

class ClassesDetailScreen extends StatelessWidget {
  static const routeName = '/Classes-Detail-Screen';
  @override
  Widget build(BuildContext context) {
    final ClassesItem classItem = ModalRoute.of(context).settings.arguments;
    final classes = Provider.of<Classes>(context, listen: false);
    final homework = Provider.of<Homework>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('ClassName'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FlatButton(
              onPressed: () {
                classes.deleteItem(classItem.id);
                homework.deleteByClassName(classItem.name);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
            Text('Detail Overview'),
          ],
        ),
      ),
    );
  }
}
