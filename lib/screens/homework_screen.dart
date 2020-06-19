import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/homework.dart' as hw;
import '../widgets/homework_item.dart';

class HomeworkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homework = Provider.of<hw.Homework>(context, listen: false);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: ListView.builder(
        itemCount: homework.itemCount,
        itemBuilder: (ctx, i) => HomeworkItem(
          homework.items.values.toList()[i],
        ),
      ),
    );
  }
}
