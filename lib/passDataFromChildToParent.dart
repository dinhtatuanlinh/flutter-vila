import 'package:flutter/material.dart';

class MyStatefulWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyStatefulWidgetState();
  // note: updated as context.ancestorStateOfType is now deprecated
  static MyStatefulWidgetState? of(BuildContext context) =>
      context.findAncestorStateOfType<MyStatefulWidgetState>();
}
class MyStatefulWidgetState extends State<MyStatefulWidget> {
  late int _string;
  set string(int value) => setState(() => _string = value);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('$_string'),
        MyChildClass(callback: (val) => setState(() => _string = val as int))
      ],
    );
  }
}
typedef void StringCallback(String val);
class MyChildClass extends StatelessWidget {
  final StringCallback callback;
  const MyChildClass({required this.callback});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FlatButton(
          onPressed: () {
            callback("String from method 1");
          },
          child: const Text("Method 1"),
        ),
        FlatButton(
          onPressed: () {
            MyStatefulWidget.of(context)?.string = 1;
          },
          child: const Text("Method 2"),
        )
      ],
    );
  }
}
void main() => runApp(
  MaterialApp(
    builder: (context, child) => SafeArea(child: Material(color: Colors.white, child: child)),
    home: MyStatefulWidget(),
  ),
);