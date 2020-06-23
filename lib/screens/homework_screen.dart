import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/homework.dart';
import '../widgets/homework_item.dart' as hw;
import '../providers/classes.dart';

class HomeworkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homework = Provider.of<Homework>(context);
    final classes = Provider.of<Classes>(context).items;

    Color _getColor(String name) {
      ClassesItem classItem = classes.firstWhere((element) => element.name == name);
      

      return classItem.color;
    }

    Widget _listOfHomeWork() {
      return ListView.builder(
        itemCount: homework.itemCount,
        itemBuilder: (ctx, i) => hw.HomeworkItem(
          homework.items.values.toList()[i],
          _getColor(homework.items.values.toList()[i].asignature),
        ),
      );
    }

    Widget _cardFea() {
      return Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Text('Hello'),
              SizedBox(width: 150),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  //Here goes more stuff
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Assigments',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) => hw.HomeworkItem(
                homework.items.values.toList()[i],
                _getColor(homework.items.values.toList()[i].asignature),
              ),
              childCount: homework.itemCount,
              
            ),
          ),
        ],
      ),
    );
  }
}
