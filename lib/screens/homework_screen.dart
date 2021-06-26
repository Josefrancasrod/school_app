import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/new_homework_screen.dart';
import '../widgets/bottom_sheet_menu.dart';
import '../providers/homework.dart';
import '../widgets/homework_item.dart' as hw;
import '../providers/classes.dart';
import '../widgets/classes_homework.dart';

class HomeworkScreen extends StatefulWidget {
  @override
  _HomeworkScreenState createState() => _HomeworkScreenState();
}

class _HomeworkScreenState extends State<HomeworkScreen> {
  var homework;

  var classes;

  bool itsFiltered = false;

  Future<void> _fetchData(BuildContext context) async {
    await Provider.of<Classes>(context, listen: false).fetchAndSetClases();
    await Provider.of<Homework>(context, listen: false).fetchAndSetHomework();

    homework = Provider.of<Homework>(context, listen: false);
    classes = Provider.of<Classes>(context, listen: false).items;
  }

  Color _getColor(String name) {
    ClassesItem classItem;
    try {
      classItem = classes.firstWhere((element) => element.name == name);
    } catch (e) {
      return null;
    }

    return classItem.color;
  }

  @override
  Widget build(BuildContext context) {
    Widget _listOfHomeWork() {
      return ListView.builder(
        itemCount: itsFiltered ? homework.numberOfHomework('asdasd6') : homework.itemCount,
        itemBuilder: (ctx, i) => hw.HomeworkItem(
          homework.items.values.toList()[i],
          _getColor(homework.items.values.toList()[i].asignature),
        ),
      );
    }

    void modal() {
      showModalBottomSheet(
        context: context,
        enableDrag: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        builder: (ctx) => Wrap(
          children: <Widget>[
            Container(
              // height: 275,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: BottomSheetMenu(),
            ),
          ],
        ),
      );
    }

    void modalFilter() {
      showModalBottomSheet(
        context: context,
        enableDrag: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        builder: (ctx) => Wrap(
          children: <Widget>[
            Container(
              // height: 275,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(child: Text("FILTER"),),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: FutureBuilder(
        future: _fetchData(context),
        builder: (ctx, dataSnapshot) => dataSnapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    title: Text(
                      'My Homework',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    leading: IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        BottomSheetMenu.modal(context);
                      },
                    ),
                    iconTheme: IconThemeData(color: Colors.black),
                    backgroundColor: Colors.grey[200],
                    flexibleSpace: Consumer<Classes>(
                      builder: (ctx, classesData, _) => FlexibleSpaceBar(
                        background: Padding(
                          padding: const EdgeInsets.only(
                            top: 90,
                            bottom: 15,
                          ),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: classesData.items.length,
                            itemBuilder: (ctx, i) => Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ClassesHomeworkCard(
                                classesData.items[i].name,
                                classesData.items[i].color,
                                homework.numberOfHomework(
                                  classesData.items[i].name,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    floating: true,
                    expandedHeight: classes.length > 0 ? 200 : 0,
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Assignments',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          IconButton(onPressed: (){
                            if(!itsFiltered){
                              setState(() {
                                homework = Provider.of<Homework>(context, listen: false).filteredByClass("asdasd6");
                                itsFiltered = true;  
                              });
                              
                            }else{
                              setState(() {
                                homework = Provider.of<Homework>(context, listen: false);
                                itsFiltered = false;  
                              });
                            }
                          }, icon: Icon(Icons.menu),)
                        ],
                      ),
                    ),
                  ),
                  Consumer<Homework>(
                    builder: (ctx, homeworkData, _) => SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (ctx, i) => Column(
                          children: <Widget>[
                            Dismissible(
                              key:
                                  Key(homeworkData.items.values.toList()[i].id),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: Colors.red,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Icon(Icons.delete, color: Colors.white),
                                      Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onDismissed: (direction) {
                                if (direction == DismissDirection.endToStart) {
                                  setState(() {
                                    homeworkData.deleteItem(
                                      homeworkData.items.values.toList()[i].id,
                                    );
                                  });

                                  Scaffold.of(context).showSnackBar(
                                    //TRY TO ADD THE UNDO BUTTON
                                    SnackBar(
                                      content: Text('Deleted'),
                                    ),
                                  );
                                }
                              },
                              confirmDismiss: (direction) async {
                                var isDismiss = false;
                                if (direction == DismissDirection.endToStart) {
                                  await showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: Text('Are you sure?'),
                                      actions: <Widget>[
                                        FlatButton(
                                          onPressed: () {
                                            isDismiss = true;
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK'),
                                        )
                                      ],
                                    ),
                                  );
                                  return isDismiss;
                                }
                              },
                              child: hw.HomeworkItem(
                                homeworkData.items.values.toList()[i],
                                _getColor(homeworkData.items.values
                                    .toList()[i]
                                    .asignature),
                              ),
                            ),
                          ],
                        ),
                        childCount: homeworkData.itemCount,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
