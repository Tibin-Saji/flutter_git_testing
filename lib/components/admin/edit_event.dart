import 'package:flutter/material.dart';
import 'package:tathva_app/globals.dart';
import 'package:http/http.dart' as http;
import 'package:tathva_app/models/event.dart';

import 'dart:async';
import 'dart:convert';

class EditEvent extends StatefulWidget {
  @override
  _EditEventState createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  
  bool _isLoading = false;
  SubCatsList subcatslist;
  bool viewcat = true;
  bool viewdetails = false;
  int categoryIndex;
  int eventIndex;

  @override
  void initState() {
    super.initState();
    loadEvents();
    setState(() {
      _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Edit Events',
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                ),
              )
            ],
          ),
          _isLoading? Center(child:CircularProgressIndicator()):
          Expanded(
            child: viewcat
              ?buildCatView()
              :(viewdetails
                ?buildEventDetails()
                :buildEventView()
              ),
          )
        ],
      ),
    );
  }

  ListView buildCatView() {
    return ListView.builder(
      itemCount: subcatslist.allevents.length,
      itemBuilder: (context,index) {
        return ListTile(
          title:Text('${subcatslist.allevents[index].subcat}'),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            setState(() {
              viewcat = false;
              viewdetails = false;
              categoryIndex = index;
            });
          },
        );
      },
    );
  }

  ListView buildEventView() {
    return ListView.builder(
      itemCount: subcatslist.allevents[categoryIndex].events.length+1,
      itemBuilder: (context,index) {
        if(index == 0)
          return ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text('Go back to Categories'),
            onTap: () {
              setState(() {
                viewdetails = false;
                viewcat = true;
              });
            },
          );
        return ListTile(
          title:Text('${subcatslist.allevents[categoryIndex].events[index-1].name}'),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            setState(() {
              viewcat = false;
              viewdetails = true;
              eventIndex = index-1;
            });
          },
        );
      },
    );
  }

  Widget buildEventDetails() {

    TextEditingController name = TextEditingController(text: '${subcatslist.allevents[categoryIndex].events[eventIndex].name}');
    TextEditingController category = TextEditingController(text: 'Event');
    TextEditingController subcategory = TextEditingController(text: '${subcatslist.allevents[categoryIndex].subcat}');
    TextEditingController description = TextEditingController(text: '${subcatslist.allevents[categoryIndex].events[eventIndex].desc}');
    // TextEditingController startDate = TextEditingController(text: '${subcatslist.allevents[categoryIndex].events[eventIndex].startDate}');
    // TextEditingController endDate = TextEditingController(text: '${subcatslist.allevents[categoryIndex].events[eventIndex].endDate}');
    // TextEditingController slots = TextEditingController(text: '${subcatslist.allevents[categoryIndex].events[eventIndex].maxSlots}');
    // String originalSD = '${subcatslist.allevents[categoryIndex].events[eventIndex].startDate}';

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text('Go back to event list'),
            onTap: () {
              setState(() {
                viewdetails = false;
                viewcat = false;
              });
            },
          ),
          SizedBox(height:30),
          TextFormField(
            enabled: false,
            controller: name,
            decoration: InputDecoration(
              hintText: "Name",
            ),
          ),
          SizedBox(height:10),
          TextFormField(
            controller: category,
            enabled: false,
            decoration: InputDecoration(
              hintText: "Category(Event/Workshop)", 
            ),
          ),
          SizedBox(height:10),
          TextFormField(
            controller: subcategory,
            decoration: InputDecoration(
              hintText: "SubCategory",
            ),
          ),
          SizedBox(height:10),
          TextFormField(
            controller: description,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText: "Description",
            ),
          ),
          SizedBox(height:10),
          // TextFormField(
          //   controller: startDate,
          //   decoration: InputDecoration(
          //     hintText: "startDate(dd-mm-yyyy)",
          //   ),
          // ),
          // SizedBox(height:10),
          // TextFormField(
          //   controller: endDate,
          //   decoration: InputDecoration(
          //     hintText: "endDate(dd-mm-yyyy)",
          //   ),
          // ),
          // SizedBox(height:10),
          // TextFormField(
          //   controller: slots,
          //   keyboardType: TextInputType.number,
          //   decoration: InputDecoration(
          //     hintText: "MaxSlots",
          //   ),
          // ),
          SizedBox(height:20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                height: 50,
                color: Colors.blue,
                child:_isLoading?Center(child:CircularProgressIndicator()):Text('Apply Changes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                  });
                  // editEvent(name.text,originalSD,subcategory.text,description.text,startDate.text,endDate.text,slots.text);
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  editEvent(String name,String prevsd,String subcat,String des,String sd,String ed,String slots) async{
    String token = await storage.read(key: "token");
    var response = await http.post('$URL/api/events/edit',
    headers: {
      "Content-type":"application/json",
      "Authorization":"Bearer $token"
    },
    body: jsonEncode(<String,dynamic> {
      "id":subcatslist.allevents[categoryIndex].events[eventIndex].id,
      "name":name,
      "previousStartDate":prevsd,
      "subcategory":subcat,
      "description":des,
      "startDate":int.parse(sd),
      "endDate":int.parse(ed),
      "maxSlots":int.parse(slots),
    }),);
    print(response.body);
    if(response.statusCode == 200) {
      setState(() {
        viewdetails = false;
        viewcat = true;
        loadEvents();
      });
    }
    else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  loadEvents() async{
    String token = await storage.read(key: "token");
    var jsonData;
    var response = await http.post('$URL/api/events/list',
    headers: {
      "Content-type":"application/json",
      "Authorization":"Bearer $token"
    },
    body: jsonEncode(<String,String>{
      "category":"event",
    }),);
    if(response.statusCode == 200) {
      setState(() {
        jsonData = json.decode(response.body);
        subcatslist = SubCatsList.fromJson(jsonData);
        print(jsonData);
        //print(subcatslist);
        _isLoading = false;
      });
    }
    else {
      setState(() {
        _isLoading = false;
      });
    }
  }
}