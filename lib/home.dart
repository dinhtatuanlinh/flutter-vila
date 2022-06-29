import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Abc extends StatelessWidget {
  const Abc({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for
    // the major Material Components.
    return Scaffold(
      appBar: AppBar(
        leading: const IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: const Text('Example title'),
        actions: const [
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
      // body is the majority of the screen.
      body: Center(
        child: fooStateful(),
      ),
      floatingActionButton: const FloatingActionButton(
        tooltip: 'Add', // used by assistive technologies
        child: Icon(Icons.add),
        onPressed: null,
      ),
    );
  }
}
typedef void StringCallback(String val);
class boo extends StatelessWidget {
  final StringCallback callback;
  boo({required this.callback});
  int _counter = 0;
  void _increment(){
    _counter++;
  }
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: _increment, child: const Text('Increment'));
  }
}

class fooStateful extends StatefulWidget {
  const fooStateful({required this.counter});
  final int counter;

  @override
  _FooChange createState() => _FooChange();
}

class _FooChange extends State<fooStateful>{
  int _counter = 0;
  void _increment(){
    setState((){
      _counter++;
    });
  }
  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(onPressed: _increment, child: const Text('Increment')),
        const SizedBox(width: 16),
        Text('Const: $_counter')
      ],
    );
  }
}




class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Home> {
  late Future<Album> futureAlbum;
  String token = "";

  Future<void> _getToken(String key) async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString(key) as String;
  }

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
    _getToken("token");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(token);
                return Text('token: ${token}');
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

// Future<Token> getToken() async{
//   final prefs = await SharedPreferences.getInstance();
//   return prefs.getString('token') ?? "";
// }

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

class Token {
  final String token;

  const Token({
    required this.token,
  });
}