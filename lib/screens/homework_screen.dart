import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/homework.dart';
import '../widgets/homework_item.dart' as hw;

class HomeworkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homework = Provider.of<Homework>(context);

    Widget _listOfHomeWork() {
      return ListView.builder(
        itemCount: homework.itemCount,
        itemBuilder: (ctx, i) => hw.HomeworkItem(
          homework.items.values.toList()[i],
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
              ),
              childCount: homework.itemCount,
            ),
          ),
        ],
      ),
      // body: ListView.builder(
      //   itemCount: homework.itemCount,
      //   itemBuilder: (ctx, i) => hw.HomeworkItem(
      //     homework.items.values.toList()[i],
      //   ),
      // ),

      //       SliverToBoxAdapter(
      //   child: Container(
      //     height: 100.0,
      //     child: ListView.builder(
      //       scrollDirection: Axis.horizontal,
      //       itemCount: homework.itemCount,
      //       itemBuilder: (ctx, i) => hw.HomeworkItem(
      //         homework.items.values.toList()[i],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
