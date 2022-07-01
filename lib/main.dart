import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vila/vila-app.dart';

import 'home.dart';
import 'login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool is_login = prefs.getString("token") != null ? true : false;
  runApp(VilaApp(is_login: is_login));
}