import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  final String className;
  final String start;
  final String finish;
  final String classroom;
  final String professorName;
  final Color color;

  ScheduleCard(this.className, this.start, this.finish, this.classroom,
      this.professorName, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      child: Container(
        height: 115,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '$start - $finish',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                    CircleAvatar(
                      maxRadius: 10,
                      backgroundColor: color,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      className.length > 14 ? className.substring(0,10) + '...' : className,
                      style:TextStyle(
                            color: color,
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.room,
                          size: 18,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 2),
                        Text(
                          classroom,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
