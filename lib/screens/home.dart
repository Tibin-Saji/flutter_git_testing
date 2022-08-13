import 'package:flutter/material.dart';
import 'package:tathvatestapp/widgets.dart';

import '../globals.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      body: Body(),
      appbar: AppBarCustom(TextCustom('Home')),
      navDrawer: NavigationDrawer(),
    );
  }

  Widget Body() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
                child: Image.asset(
              'assets/tathvaLogo.jpg',
              scale: 1,
            )),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 32, top: 16),
              child: TextCustom(
                  '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam non pretium erat, id malesuada justo. Maecenas odio nibh, vehicula non arcu vitae, varius venenatis neque. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Vivamus finibus venenatis magna, sed suscipit urna imperdiet eu. Curabitur nec hendrerit tortor. Aliquam in elementum nisi. Vivamus tempor interdum lacinia. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In in libero diam. Mauris libero nibh, dictum sed feugiat eget, blandit vitae diam. Aliquam et ex id erat volutpat tincidunt. Sed sit amet erat in sem imperdiet vehicula non et lectus.

Etiam nec sodales erat. Maecenas maximus faucibus libero sed ornare. Nam vitae gravida odio. Phasellus condimentum molestie sem. Sed quis velit eget neque maximus elementum. Donec ullamcorper convallis mi, eu pretium arcu porttitor eu. Suspendisse at ullamcorper nibh, sed dapibus tellus. Vestibulum ac mi ipsum.

Cras quis nunc et arcu suscipit finibus. Etiam malesuada volutpat tellus non bibendum. Fusce in rutrum odio. Phasellus malesuada leo a justo scelerisque, ac posuere sem posuere. Interdum et malesuada fames ac ante ipsum primis in faucibus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nam vehicula et tellus sit amet viverra. Integer nec nunc non diam vehicula sodales.'''),
            )
          ],
        ),
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: bg1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          children: buildMenuItems(context),
        ),
      ),
    );
  }

  List<Widget> buildMenuItems(BuildContext context) {
    return [
      ListTile(
        leading: Icon(Icons.person),
        title: TextCustom('My Account'),
      ),
      ListTile(
        leading: Icon(Icons.person),
        title: TextCustom('My Account'),
      ),
      ListTile(
        leading: Icon(Icons.person),
        title: TextCustom('My Account'),
      ),
    ];
  }
}
