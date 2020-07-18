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
              fontFamily: 'Montserrat',
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Colors.grey[700],
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey[700],
            thickness: 1,
          ),
        ),
      ],
    );
    ;
  }
}
