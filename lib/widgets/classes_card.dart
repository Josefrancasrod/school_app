import 'package:flutter/material.dart';

import '../screens/new_classes_screen.dart';
import '../screens/classes_detail_screen.dart';
import '../providers/classes.dart';

class ClassesCard extends StatelessWidget {
  final ClassesItem classesItem;

  ClassesCard({this.classesItem});

  void _openNewScreen({
    @required bool containsData,
    String id,
    @required BuildContext ctx,
  }) {
    if (!containsData) {
      Navigator.of(ctx).pushNamed(ClassesDetailScreen.routeName);
    } else {
      Navigator.of(ctx).pushNamed(NewClassesScreen.routeName);
    }
  }

  Widget _classesCard(bool containsData, BuildContext ctx) {
    return InkWell(
      onTap: () => containsData
          ? _openNewScreen(containsData: containsData, ctx: ctx)
          : _openNewScreen(
              containsData: containsData, id: classesItem.name, ctx: ctx),
      splashColor: Theme.of(ctx).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: containsData
            ? Center(
                child: Icon(
                  Icons.add,
                  color: Colors.grey,
                ),
              )
            : Text(
                classesItem.name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
        decoration: containsData
            ? BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15),
              )
            : BoxDecoration(
                color: classesItem.color,
                borderRadius: BorderRadius.circular(15),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool containsItems = classesItem == null;
    return _classesCard(containsItems, context);

  }
}