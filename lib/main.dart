import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(
      MaterialApp(
        title: 'Flutter Tutorial',
        home: Abc(),
      )
  );
  // if(prefs.getString("token") != ""){
  //   runApp(Abc());
  // }else{
  //   runApp(Login());
  // }
}