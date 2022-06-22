import 'package:flutter/material.dart';

class register extends StatelessWidget{

  const register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
        title: 'abc',
        home: Scaffold(
          appBar: AppBar(title: const Text('123')),
          body: Padding(
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
                        'Register',
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
                  // TextButton(
                  //   onPressed: () {
                  //     //forgot password screen
                  //   },
                  //   child: const Text('Forgot Password',),
                  // ),
                  // Container(
                  //     height: 50,
                  //     padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  //     child: ElevatedButton(
                  //       child: const Text('Login'),
                  //       onPressed: () {
                  //         print(nameController.text);
                  //         print(passwordController.text);
                  //       },
                  //     )
                  // ),
                  // Row(
                  //   children: <Widget>[
                  //     const Text('Does not have account?'),
                  //     TextButton(
                  //       child: const Text(
                  //         'Sign in',
                  //         style: TextStyle(fontSize: 20),
                  //       ),
                  //       onPressed:() {
                  //         Navigator.push(
                  //           context, MaterialPageRoute(
                  //           builder: (context) => register(),
                  //         ),
                  //         );
                  //       },
                  //     )
                  //   ],
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  // ),
                ],
              ))
        ),
      );

  }
}