import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/classes.dart';
import '../widgets/classes_card.dart';

class ClassesScreen extends StatelessWidget {
  static const routeName = "/classes-screen";
  @override
  Widget build(BuildContext context) {
    final classes = Provider.of<Classes>(context).items;
    List<Widget> classesList = classes
            .map(
              (data) => ClassesCard(classesItem: data,),
            )
            .toList();

    classesList.add(ClassesCard());

    return Scaffold(
      appBar: AppBar(title: Text('My Classes'),),
      body: GridView(
        padding: const EdgeInsets.all(10),
        children: classesList,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
