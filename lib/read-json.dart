import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class readJson {
  // var connectCustomer;
  //
  // readJson(String path) {
  //   this.connectCustomer = this.jsDecode(this.getCustomerConnectionJson(path));
  // }
  //
  // Map<String, String> Header() {
  //   final Map<String, String> Header = Map.castFrom(this.connectCustomer['header']);
  //   return Header;
  // }
  // Future<String> Domain() async {
  //   print("@@@@");
  //   var result = this.connectCustomer['domain'];
  //   print(result);
  //   return "dfasdfsad";
  // }
  //
  // Future<String> getCustomerConnectionJson(String path) async {
  //
  //   String result = await rootBundle.loadString(path);
  //
  //   return result;
  // }
  //
  // jsDecode(jsonString) async {
  //   jsonString = await jsonString;
  //   return jsonDecode(jsonString);
  // }

  // Future<String> domain(path) async {
  //   String result = await rootBundle.loadString(path);
  //   var data = jsonDecode(result);
  //   return data['domain'];
  // }
  String data = "";
  int so = 0;
  readJson(String path) {
    importFile(path);
    print(data);
  }
  importFile(String path)async{
    data = await rootBundle.loadString(path);
    print(data);
  }

  domain() async{
    // print(json.decode(this.data)['domain']);
    return jsonDecode(await data)['domain'];
  }
}

