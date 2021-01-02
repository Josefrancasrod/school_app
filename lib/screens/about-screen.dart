import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import '../widgets/custom_icons.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = '/About-Screen';

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('School App'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Column(
          children: [
            Center(
              child: Text(
                'Hi! This app was created only as practice of app development with Flutter.' +
                    ' This is version 1.0.0 that means the app only have basic functionalities and some bugs.' +
                    ' If you want a new feature or you find a bug, please, let me know.'+
                    ' Also if you like the app make a good review on the store.' +
                    '\n\nThe Flutter code is free and you can find it on my GitHub, if you want colaborate, you are free to make a fork or let a issue in the repo.' +
                    '\n\nThanks for ussing School App.\n\n',
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    CustomIcons.github_square,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {
                    _launchURL('https://github.com/Josefrancasrod');
                  },
                ),
                IconButton(
                  icon: Icon(
                    CustomIcons.instagram,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {
                    _launchURL('https://www.instagram.com/josefrancasrod');
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Text(
                  'Made with flutter and <3 by @josefrancasrod.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
