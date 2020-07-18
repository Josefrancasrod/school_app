import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/screens/new_classes_screen.dart';

import '../providers/homework.dart';
import '../widgets/homework_item.dart' as hw;
import '../providers/classes.dart';
import '../widgets/classes_homework.dart';

class HomeworkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homework = Provider.of<Homework>(context);
    final classes = Provider.of<Classes>(context).items;

    Color _getColor(String name) {
      ClassesItem classItem =
          classes.firstWhere((element) => element.name == name);
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
    
    void _modal() {
      showModalBottomSheet(
        context: context,
        enableDrag: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        builder: (ctx) => Column(
          children: <Widget>[
            //ONLY FOR TEST, DELETE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, NewClassesScreen.routeName);
                },
                icon: Icon(
                  Icons.school,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              'My Homework',
              style: Theme.of(context).textTheme.headline6,
            ),
            leading: IconButton(icon: Icon(Icons.menu), onPressed: _modal),
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.grey[200],
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.only(
                  top: 90,
                  bottom: 15,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: classes.length,
                  itemBuilder: (ctx, i) => Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ClassesHomeworkCard(
                      classes[i].name,
                      classes[i].color,
                      homework.numberOfHomework(classes[i].name),
                    ),
                  ),
                ),
              ),
            ),
            floating: true,
            expandedHeight: 200,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Text(
                'Assigments',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) => Column(
                children: <Widget>[
                  hw.HomeworkItem(
                    homework.items.values.toList()[i],
                    _getColor(homework.items.values.toList()[i].asignature),
                  ),
                ],
              ),
              childCount: homework.itemCount,
            ),
          ),
        ],
      ),
    );
  }
}
