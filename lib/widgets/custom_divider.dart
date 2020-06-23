import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final text;

  CustomDivider(this.text);
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
        ),
        Expanded(
          child: Divider(
            color: Theme.of(context).primaryColor,
            thickness: 1,
          ),
        ),
      ],
    );;
  }
}