import 'package:flutter/material.dart';

class NewClassesScreen extends StatelessWidget {
  static const routeName = '/New-Classes-Screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Class'),
      ),
      body: Center(
        child: Text('New/add classes'),
      ),
    );
  }
}
