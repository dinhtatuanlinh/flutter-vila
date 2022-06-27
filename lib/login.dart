import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vila/read-json.dart';
import 'Register.dart';
import 'otp.dart';
import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';

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
                          // print(futureResult.data?.token);
                          if (futureResult.status == "success") {
                            print(futureResult.status);
                            Navigator.push(
                              context, MaterialPageRoute(
                                builder: (context) => OTP(username: nameController.text, password: passwordController.text),
                              ),
                            );
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

// Map<String, String> Header = {
//   "OS-NAME": "android",
//   "OS-VERSION": "2.0.1",
//   "APP-VERSION": "1.0.0",
//   "Content-Type": "application/json",
//   "DEVICE-NAME": "iphone 6",
//   "DEVICE-TOKEN": "JSNBDVANDBCKSJSXDANKBVABN",
//   "FCM-TOKEN": "JSNBDVANDBCKSJSXDANKBVABNJSNBDVANDBCKSJSXDANKBVABJSNBDVANDBCKSJSXDANKBVABN"
// };
Future<Result> fetchLogin(String username, String password) async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if(Platform.isAndroid){
    AndroidDeviceInfo info = await deviceInfo.androidInfo;
    print(info.version);
    print(info.board);
    // print(info.bootloader);
    print(info.brand);
    print(info.device);
    print("#######################");
  }else if(Platform.isIOS){
    IosDeviceInfo info = await deviceInfo.iosInfo;
    print(info.name);
    print(info.systemName);
    print(info.systemVersion);
    print(info.model);
    print(info.localizedModel);
  }
  var data = new readJson();
  await data.importFile('assets/connect-customer.json');
  String body = '{ "account":"${username}", "pass":"${password}" }';
  final response = await http.post(
      Uri.parse('${await data.domain()}/v1/api/login'),
      headers: await data.Header(),
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
  final Data? data;

  const Result({
    required this.code,
    required this.status,
    required this.message,
    this.data,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      code: json['code'],
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : Data.fromJson({"token": ""})
    );
  }
}