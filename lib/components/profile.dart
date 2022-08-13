import 'package:flutter/material.dart';
import 'package:tathva_app/globals.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Profile extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 250,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              QrImage(
                data: user.id,
                version: QrVersions.auto,
                size: 200,
              )
            ],
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Tathva ID : ${user.id}',
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
        Expanded(
          child: ListView(children: <Widget>[
            ListTile(
              title: Text('Name: ' + user.name),
            ),
            ListTile(
              title: Text('College: ' + user.college),
            ),
            ListTile(
              title: Text('Email ID: ' + user.email),
            ),
            ListTile(
              title: Text('Phone Number: ' + user.phoneno),
            ),
            ListTile(
              title: Text(
                  'Events Registered: ' + user.events.toString()),
            ),
          ]),
        )
      ],
    );
  }
}