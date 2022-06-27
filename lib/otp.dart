import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vila/read-json.dart';
import 'Register.dart';
import 'home.dart';

class OTP extends StatelessWidget {
  static const String _title = 'Sample App';
  const OTP({ required this.username, required this.password});
  final String username;
  final String password;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        // appBar: AppBar(title: const Text(_title)),
        body: OPTStatefulWidget(username: username, password: password),
      ),
    );
  }
}

class OPTStatefulWidget extends StatefulWidget {
  const OPTStatefulWidget({required this.username, required this.password});
  final String username;
  final String password;

  @override
  State<OPTStatefulWidget> createState() => _OTPStatefulWidgetState();
}

class _OTPStatefulWidgetState extends State<OPTStatefulWidget> {
  late Result futureResult;

  // Future<void> _saveToken(String token) async{
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('token', token);
  // }


  TextEditingController OTPController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
      Center(
          child:Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'VILA',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 30),
                      )),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: OTPController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'OTP code',
                      ),
                    ),
                  ),

                  Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        child: const Text('Submit'),
                        onPressed: () async {
                          print(widget.username);
                          futureResult = await fetchLogin(widget.username, widget.password, OTPController.text);

                          if (futureResult.status == "success") {
                            print('object');
                            print(futureResult.data.token);
                            // _saveToken(futureResult.data.token);
                            // Navigator.push(
                            //   context, MaterialPageRoute(
                            //     builder: (context) => Home(),
                            //   ),
                            // );
                          } else{
                            print(futureResult.message);
                          }
                        },
                      )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Does not have account?'),
                      TextButton(
                        child: const Text(
                          'Sign in',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed:() {
                          Navigator.push(
                            context, MaterialPageRoute(
                            builder: (context) => Register(),
                          ),
                          );
                        },
                      )
                    ],
                  ),
                ],
              )
          )
      );
  }
}

Future<Result> fetchLogin(String username, String password, String otp) async {
  var data = new readJson();
  await data.importFile('assets/connect-customer.json');
  String body = '{ "account":"${username}", "pass":"${password}", "otp": "${otp}" }';
  final response = await http.post(
      Uri.parse('${await data.domain()}/v1/api/login/confirm-otp'),
      headers: await data.Header(),
      body: body
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    return Result.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,

    throw Exception('Failed to load album');
  }
}

class Data {
  final String token;
  const Data({
    required this.token
  });
  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      token: json['token']
    );
  }
}

class Result {
  final String code;
  final String status;
  final String message;
  final Data data;


  const Result({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      code: json['code'],
      status: json['status'],
      message: json['message'],
      data: Data.fromJson(json['data'])
    );
  }
}