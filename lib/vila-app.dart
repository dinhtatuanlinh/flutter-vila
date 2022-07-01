import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'login.dart';
import 'provider-models.dart';

class VilaApp extends StatelessWidget {
  bool is_login = false;
  VilaApp({required this.is_login});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CounterModel>(create: (context) => CounterModel()),
        ChangeNotifierProvider<CongModel>(create: (context)=> CongModel()),
      ],
      child: MaterialApp(
        title: 'Vila App',
        initialRoute: is_login ? Home.routeName : Login.routeName,
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          Login.routeName: (context) => Login(),
          Home.routeName: (context)=> Home(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          // '/second': (context) => const SecondScreen(),
        },
        // home: CounterView(),
      ),
    );
  }
}