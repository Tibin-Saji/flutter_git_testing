import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tathva_app/globals.dart';
import 'package:http/http.dart' as http;

class EmailVerify extends StatefulWidget {
  @override
  _EmailVerifyState createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  bool _isLoading = false;
  TextEditingController email = TextEditingController();
  String status = "Enter email to be verified";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _isLoading? Center(child:CircularProgressIndicator()):Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            SizedBox(height:10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Verify Email',
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                  ),
                )
              ],
            ),
            SizedBox(height:20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: (MediaQuery.of(context).size.width)*0.5,
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      hintText: "Email",
                    ),
                  ),
                ),
                MaterialButton(
                  color: Colors.blue,
                  minWidth: (MediaQuery.of(context).size.width)*0.25,
                  child: Text('Verify',style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                    });
                    verify(email.text);
                  }
                )
              ],
            ),
            SizedBox(height:20),
            Text(status,style: TextStyle(fontSize: 20),),
          ],
        ),
      ),
    );
  }

  verify(String email) async{
    String token = await storage.read(key: "token");
    var response = await http.post('$URL/api/admin/verify',
    headers: {
      "Content-type":"application/json",
      "Authorization":"Bearer $token"
    },
    body: jsonEncode(<String,String> {
      "email":email,
    }),);
    print("Bearer $token");
    if(response.statusCode == 200) {
      print(response.body);
      setState(() {
        status = "Success";
        _isLoading = false;  
      });    
    }
    else {
      print(response.body);
      setState(() {
        status = "Invalid";
        _isLoading = false;  
      });
    }
  }
}
