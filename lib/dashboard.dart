import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:tathva_app/components/displayid.dart';
import 'package:tathva_app/components/profile.dart';
import 'package:tathva_app/components/eventAdmin/addParticipant.dart';
import 'package:tathva_app/components/admin/email.dart';
import 'package:tathva_app/components/admin/create_event.dart';
import 'package:tathva_app/components/admin/edit_event.dart';
import 'package:tathva_app/components/admin/roles.dart';
import 'package:tathva_app/components/scan.dart';
import 'package:tathva_app/components/messages.dart';
import 'package:tathva_app/login.dart';
import 'package:tathva_app/map.dart';

class Dashboard extends StatefulWidget {
  final String role;
  Dashboard({@required this.role});
  @override
  _DashboardState createState() => _DashboardState(role);
}

class _DashboardState extends State<Dashboard> {
  final String role;
  Widget _page;
  _DashboardState(this.role);
  List<Widget> drawerItems;
  
  @override
  void initState() {
    super.initState();
    if(role == 'participant')
      _page = Profile();
    else
      _page = Scan();
      FirebaseNotifications().setUpFirebase(context);
  }
  
  void logOut() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    Navigator.pop(context);
    login.setString('userdetails', null);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()),);  
  }

  @override
  Widget build(BuildContext context) {
    Widget navDrawer(List<Widget> items) {
      return Drawer(child: ListView(children: items));
    }
    if (role == 'participant') {
      drawerItems = [
        DrawerHeader(
          child: Text('Tathva \'20'),
        ),
        ListTile(
          title: Text('HomePage'),
          onTap: () {
            Navigator.pop(context);
            setState(() {
              _page = Profile();
            });
          },
        ),
        ListTile(
          title: Text('Map'),
          onTap: ()
          {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Map()));
          },
        ),
        ListTile(
          title: Text('Schedule'),
        ),
        ExpansionTile(
          title: Text('Events'),
          children: <Widget>[
            ListTile(
              title: Text('Category 1'),
            ),
            ListTile(
              title: Text('Category 2'),
            ),
          ],
        ),
        ListTile(
          title: Text('Log Out'),
          onTap: () => logOut(),
        )
      ];
    }
    if(role == 'volunteer') {
      drawerItems = [
        DrawerHeader(
          child: Text('Tathva \'20'),
        ),
        ListTile(
          title:Text('Home'),
          onTap: () {
            Navigator.pop(context);
            setState(() {
              _page = Scan();
            });
          },
        ),
        ListTile(
          title: Text('Show ID'),
          onTap: () {
            Navigator.pop(context);
            setState(() {
              _page = DisplayQR();
            });
          },
        ),
        ListTile(
          title: Text('Log Out'),
          onTap: () => logOut(),
        )
      ];
    }
    if(role == 'eventHead') {
      drawerItems = [
        DrawerHeader(
          child: Text('Tathva \'20'),
        ),
        ListTile(
          title:Text('Home'),
          onTap: () {
            Navigator.pop(context);
            setState(() {
              _page = Scan();
            });
          },
        ),
        ListTile(
          title:Text('Add Participant'),
          onTap: () {
            Navigator.pop(context);
            setState(() {
              _page = AddParticipant();
            });
          },
        ),
        ListTile(
          title: Text('Show ID'),
          onTap: () {
            Navigator.pop(context);
            setState(() {
              _page = DisplayQR();
            });
          },
        ),
        ListTile(
          title: Text('Log Out'),
          onTap: () => logOut(),
        )
      ];
    }
    if(role == 'admin') {
      drawerItems = [ 
        DrawerHeader(

          child: Text('Tathva \'20'),
        ),
        ListTile(
          title:Text('Home'),
          onTap: () {
            Navigator.pop(context);
            setState(() {
              _page = Scan();
            });
          },
        ),
        ListTile(
          title:Text('Verify Email'),
          onTap: () {
            Navigator.pop(context);
            setState(() {
              _page = EmailVerify();
            });
          },
        ),
        ListTile(
          title:Text('Change Roles'),
          onTap: () {
            Navigator.pop(context);
            setState(() {
              _page = Roles();
            });
          },
        ),
        ListTile(
          title:Text('Create Event'),
          onTap: () {
            Navigator.pop(context);
            setState(() {
              _page = CreateEvent();
            });
          },
        ),
        ListTile(
          title:Text('Events (Should route to the user events page once its done)'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title:Text('Edit Events'),
          onTap: () {
            Navigator.pop(context);
            setState(() {
              _page = EditEvent();
            });
          },
        ),
        ListTile(
          title: Text('Log Out'),
          onTap: () => logOut(),
        )
      ];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Tathva 20'),
      ),
      body: Container(
        child: _page,
      ),
      drawer: navDrawer(drawerItems),
    );
  }


}