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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                width: 200,
                height: 200,
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                ),
              ),
              Center(
                child: Text(
                  'Hi! This app was created only as training of app development with Flutter.' +
                      ' If you want a new feature or you find a bug, please, let me know.' +
                      ' Also if you like the app make a good review on the store.' +
                      '\n\nThe Flutter code is free and you can find it on my GitHub, if you want to collaborate, you are free to make a fork or let an issue in the repo.' +
                      '\n\nThanks for using School App.\n\n',
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
      ),
    );
  }
}
