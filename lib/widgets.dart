import 'package:flutter/material.dart';

import 'globals.dart';

class ScreenTemplate extends StatelessWidget {
  ScreenTemplate(
      {Key? key, required this.body, required this.appbar, this.navDrawer})
      : super(key: key);

  Widget body;
  PreferredSizeWidget appbar;
  Widget? navDrawer;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [bg1, bg2],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.2, 0.5])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: navDrawer,
        body: body,
        appBar: appbar,
      ),
    );
  }
}

AppBarCustom(Widget title) => AppBar(
      title: title,
      centerTitle: true,
      backgroundColor: Colors.transparent,
    );

class TextCustom extends StatelessWidget {
  // const TextSmall({Key? key}) : super(key: key);

  String text;
  TextAlign align;
  Color color;
  double size;
  FontWeight weight;

  TextCustom(this.text,
      {Key? key,
      this.align = TextAlign.left,
      this.color = Colors.white,
      this.size = 22,
      this.weight = FontWeight.w500})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: align,
        style: TextStyle(
          fontWeight: weight,
          fontSize: size,
          color: color,
          fontFamily: 'Exo2',
        ));
  }
}
