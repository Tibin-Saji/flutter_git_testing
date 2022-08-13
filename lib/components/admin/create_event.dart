import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tathva_app/globals.dart';
import 'dart:convert';


class CreateEvent extends StatefulWidget {
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  
  TextEditingController name = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController subcategory = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController slots = TextEditingController();
  
  bool _isLoading = false;
  String status = '';
  DateTime stDate = DateTime.now();
  TimeOfDay stTime = TimeOfDay.now();
  DateTime enDate;
  TimeOfDay enTime;
  String sDate;
  String eDate;
  String sTime;
  String eTime;

  @override
  void initState() {
    super.initState();
    enDate = stDate.add(Duration(hours: 1));
    enTime = TimeOfDay.fromDateTime(enDate);
    sDate = '${stDate.toLocal()}'.split(' ')[0];
    sTime = '${stDate.toLocal()}'.split(' ')[1];
    eDate = '${enDate.toLocal()}'.split(' ')[0];
    eTime = '${enDate.toLocal()}'.split(' ')[1];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Create Event',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    ),
                  )
                ],
              ),
              SizedBox(height:30),
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                  hintText: "Name",
                ),
              ),
              SizedBox(height:10),
              TextFormField(
                controller: category,
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
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Description",
                ),
              ),
              SizedBox(height:20),
              TextFormField(
                controller: slots,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "MaxSlots",
                ),
              ),
              SizedBox(height:20),
              ListTile(
                title: InkWell(
                  onTap: () {
                    _selectStartDate(context);
                  },
                  child:Text(sDate,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )
                ),
                trailing: InkWell(
                  onTap: () {
                    _selectStartTime(context);
                  },
                  child:Text(sTime.substring(0,5),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: InkWell(
                  onTap: () {
                    _selectEndDate(context);
                  },
                  child:Text(eDate,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )
                ),
                trailing: InkWell(
                  onTap: () {
                    _selectEndTime(context);
                  },
                  child:Text(eTime.substring(0,5),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(height:10),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    height: 50,
                    color: Colors.blue,
                    child:_isLoading?Center(child:CircularProgressIndicator()):Text('Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                      });
                      newEvent(name.text,category.text,subcategory.text,description.text,slots.text);
                    },
                  )
                ],
              ),
              SizedBox(height:20),
              Text(status,style: TextStyle(fontSize:25),)
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> _selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: stDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2099));
    if (picked != null && picked != stDate)
      setState(() {
        stDate = picked;
        sDate = '${stDate.toLocal()}'.split(' ')[0];
      });
  }

  Future<Null> _selectEndDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: enDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2099));
    if (picked != null && picked != enDate)
      setState(() {
        enDate = picked;
        eDate = '${enDate.toLocal()}'.split(' ')[0];
      });
  }

  Future<Null> _selectStartTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: stTime, builder: (BuildContext context, Widget child) {
           return MediaQuery(
             data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );});

    if (picked != null && picked != stTime )
      setState(() {
        stTime = picked;
        stDate = DateTime(stDate.year,stDate.month,stDate.day,stTime.hour,stTime.minute);
        sTime = '${stDate.toLocal()}'.split(' ')[1]; 
      });
  }

  Future<Null> _selectEndTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: enTime, builder: (BuildContext context, Widget child) {
           return MediaQuery(
             data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );});

    if (picked != null && picked != enTime )
      setState(() {
        enTime = picked;
        enDate = DateTime(enDate.year,enDate.month,enDate.day,enTime.hour,enTime.minute);
        eTime = '${enDate.toLocal()}'.split(' ')[1];
      });
  }

  newEvent(String name,String cat,String subcat,String des,String slots) async{
    String token = await storage.read(key: "token");
    var response = await http.post('$URL/api/events/create',
    headers: {
      "Content-type":"application/json",
      "Authorization":"Bearer $token"
    },
    body: jsonEncode(<String,dynamic> {
      "name":name,
      "category":cat,
      "subcategory":subcat,
      "description":des,
      "startDate":stDate.millisecondsSinceEpoch,
      "endDate":enDate.millisecondsSinceEpoch,
      "maxSlots":int.parse(slots),
    }),);
    print(stDate.millisecondsSinceEpoch);
    print(response.body);
    if(response.statusCode == 201) {
      setState(() {
        status = "Success";
        _isLoading = false;
      });
    }
    else {
      setState(() {
        status = "Invalid";
        _isLoading = false;
      });
    }
  }
}