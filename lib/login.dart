import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tathva_app/dashboard.dart';
import 'dart:convert';
import 'dart:async';
import 'package:tathva_app/models/user.dart';
import 'package:tathva_app/models/errors.dart';
import 'package:tathva_app/globals.dart';

bool authFlag = false;
TextEditingController id = TextEditingController();
TextEditingController pw = TextEditingController(text: '');

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  BuildContext scaffoldcontext;

  @override
  void initState() {
    super.initState();
    autoLogIn();
  }

  void autoLogIn() async {
    final SharedPreferences login = await SharedPreferences.getInstance();
    final String userdetails = login.getString('userdetails');

    if (userdetails != null) {
      print(userdetails);
      var jsonData = json.decode(login.getString('userdetails'));
      // await storage.write(key:"token",value: jsonData['token']);
      print("SUCCESS");
      user = User.fromJson(jsonData['user']);
      print(user.name);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Dashboard(role: user.role)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Builder(builder: (BuildContext context) {
        scaffoldcontext = context;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container(
                width: double.infinity,
                height: 350,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 15),
                      blurRadius: 15,
                    ),
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, -10),
                      blurRadius: 10,
                    )
                  ]),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Login",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          letterSpacing: .6,
                          fontSize: 45
                        ),
                      ),
                      Text("Username",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                        )
                      ),
                      TextFormField(
                        controller: id,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text("Password",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                        )
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: pw,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          MaterialButton(
                            minWidth: 125,
                            height: 50,
                            color: Colors.black,
                            child: _isLoading
                              ? Center(child: CircularProgressIndicator())
                              : Text(
                                  'SignIn',
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 25,
                                    color: Colors.white,
                                ),
                              ),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (id.text.isEmpty) {
                                Scaffold.of(scaffoldcontext).hideCurrentSnackBar();
                                Scaffold.of(scaffoldcontext)
                                  .showSnackBar(SnackBar(
                                    content: Text("ID is required"),
                                  )
                                );
                              } else if (pw.text.isEmpty) {
                                Scaffold.of(scaffoldcontext).hideCurrentSnackBar();
                                Scaffold.of(scaffoldcontext)
                                  .showSnackBar(SnackBar(
                                    content: Text("Password is required"),
                                  )
                                );
                              } else {
                                setState(() {
                                  _isLoading = true;
                                });
                                loginAuth(id.text, pw.text);
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        );
      }),
    );
  }

  loginAuth(String email, String password) async {
    var jsonData;
    var response = await http.post(
      '$URL/api/auth/signin',
      headers: {"Content-type": "application/json"},
      body: jsonEncode(<String, String>{"email": email, "password": password}),
    );
    print(response.body);
    jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      await storage.write(key: "token", value: jsonData['token']);
      final SharedPreferences login = await SharedPreferences.getInstance();
      login.setString('userdetails', response.body);
      user = User.fromJson(jsonData['user']);
      setState(() {
        _isLoading = false;
        print(jsonData['token']);
        print(login.getString('userdetails'));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dashboard(role: user.role)),
        );
      });
    } else {
      var error = Error.fromJson(jsonData['errors']);
      setState(() {
        _isLoading = false;
        Scaffold.of(scaffoldcontext).hideCurrentSnackBar();
        Scaffold.of(scaffoldcontext).showSnackBar(SnackBar(
          content: Text(error.message),
        ));
      });
    }
  }
}