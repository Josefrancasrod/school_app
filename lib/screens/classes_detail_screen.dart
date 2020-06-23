import 'package:flutter/material.dart';

class ClassesDetailScreen extends StatelessWidget {
  static const routeName = '/Classes-Detail-Screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ClassName'),
      ),
      body: Center(
        child: Text('Detail Overview'),
      ),
    );
  }
}
