import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/homework.dart';
import '../widgets/homework_item.dart' as hw;

class HomeworkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homework = Provider.of<Homework>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: ListView.builder(
        itemCount: homework.itemCount,
        itemBuilder: (ctx, i) => hw.HomeworkItem(
          homework.items.values.toList()[i],
        ),
      ),
    );
  }
}
