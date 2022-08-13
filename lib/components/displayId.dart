import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tathva_app/globals.dart';

class DisplayQR extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}