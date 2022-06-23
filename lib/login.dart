import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Register.dart';
import 'home.dart';

Map<String, String> Hearder = {
  "OS-NAME": "android",
  "OS-VERSION": "2.0.1",
  "APP-VERSION": "1.0.0",
  "Content-Type": "application/json",
  "DEVICE-NAME": "iphone 6",
  "DEVICE-TOKEN": "JSNBDVANDBCKSJSXDANKBVABN",
  "FCM-TOKEN": "JSNBDVANDBCKSJSXDANKBVABNJSNBDVANDBCKSJSXDANKBVABJSNBDVANDBCKSJSXDANKBVABN",
};

Future<Result> fetchLogin(String username, String password) async {

  String body = '{ "account":"${username}", "pass":"${password}" }';
  print(body);
  final response = await http.post(
      Uri.parse('https://customer.vila-co.com/v1/api/login'),
      headers: Hearder,
      body: body
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
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
    print('11111');
    print(json['message']);
    print('1111111111');
    return Result(
      code: json['code'],
      status: json['status'],
      message: json['message'],
      data: Data.fromJson(json['data'])
    );
  }
}

class Login extends StatelessWidget {
  static const String _title = 'Sample App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        // appBar: AppBar(title: const Text(_title)),
        body: const LoginStatefulWidget(),
      ),
    );
  }
}

class LoginStatefulWidget extends StatefulWidget {
  const LoginStatefulWidget({Key? key}) : super(key: key);

  @override
  State<LoginStatefulWidget> createState() => _LoginStatefulWidgetState();
}

class _LoginStatefulWidgetState extends State<LoginStatefulWidget> {
  late Result futureResult;

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //forgot password screen
                    },
                    child: const Text('Forgot Password',),
                  ),
                  Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        child: const Text('Login'),
                        onPressed: () async {
                          futureResult = await fetchLogin(nameController.text, passwordController.text);

                          if (futureResult.status == "success") {
                            print('object');
                            print(futureResult.status);
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