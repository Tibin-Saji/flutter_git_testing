import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recase/recase.dart';
import 'package:tathva_app/globals.dart' as globals;
import 'package:tathva_app/models/session.dart';
import 'package:tathva_app/models/user.dart';

class ParticipantList extends StatefulWidget {
  @override
  _ParticipantListState createState() => _ParticipantListState();
}

class _ParticipantListState extends State<ParticipantList> {
  final dropdownItems = ['event', 'lecture', 'workshop'];
  String _eventCategory;
  String _eventName;
  List<UserFetchDTO> _participants;
  @override
  Widget build(BuildContext context) {
    //   {
    //   "_id": "5e9fce650e87ad0004a6364e",
    //   "name": "Anandu",
    //   "email": "mail@anandu.net",
    //   "__v": 0
    // }
    // event OR lecture OR workshop

    Future<List<UserFetchDTO>> _getParticipants(String eventName) async {
      final token = await globals.storage.read(key: 'token');
      final response =
          await http.post(globals.URL + 'api/events/list-participants',
              headers: {
                'Authorization': 'Bearer ' + token,
                'Content-Type': 'application/json',
              },
              body: jsonEncode({'eventName': eventName}));
      setState(() {
        _participants = jsonDecode(response.body)
            .map((participant) => UserFetchDTO.fromJson(participant))
            .toList();
      });
      return _participants;
    }

    final dropdown = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButton(
          hint: Text('Select a role'),
          value: _eventCategory,
          items: dropdownItems.map((String val) {
            return DropdownMenuItem(
                value: val.titleCase,
                child: SizedBox(
                  child: Text(
                    val,
                    style: TextStyle(color: Colors.black),
                  ),
                  width: 100,
                ));
          }).toList(),
          onChanged: (val) {
            setState(() {
              _eventCategory = val;
            });
          }),
    );
    Widget screen() {
      if (_eventName == null) {
        return Center(
          child: RaisedButton(
              child: Row(
                children: <Widget>[
                  Icon(Icons.search),
                  Text("Search for Event")
                ],
              ),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: EventSearch(),
                );
              }),
        );
      }
    }

    return screen();
  }
}

class EventSearch extends SearchDelegate<String> {
  Session _events;
  Future<List<Session>> getEvents() async {
    final token = await globals.storage.read(key: 'token');
    final response = await http.get(
      globals.URL + '/api/session/list',
      headers: {
        'Authorization': 'Bearer ' + token,
      },
    );
    if (response.statusCode == 200) {
      _events = jsonDecode(response.body).map((val) => Session.fromJson(val)).toList();
      return _events;
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: (){
        query = '';
      },)
    ]
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
      close(context, null);
    },);
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return FutureBuilder(
      future: ,
      builder: (context, AsyncSnapshot<String>),
    )
  }
}